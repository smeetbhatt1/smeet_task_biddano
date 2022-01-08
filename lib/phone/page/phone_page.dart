import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smeet_task/phone/provider/phone_provider.dart';
import 'package:smeet_task/widgets/my_expansion.dart';
import 'package:smeet_task/widgets/progress_bar.dart';

class PhonePage extends StatefulWidget {
  static const String routeName = "/phone-page";
  const PhonePage({Key? key}) : super(key: key);

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<PhoneProvider>(context, listen: false).getPhones();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone"),
      ),
      body: Selector<PhoneProvider, bool>(
        selector: (_, p,) => p.showLoader,
        builder: (_, value, __) {
          return value
              ? const ProgressBar()
              : _buildListView();
        },
      ),
    );
  }

  Widget _buildListView() {
    return Consumer<PhoneProvider>(
      builder: (_, p, __) => ListView.separated(
        itemCount: p.phones.length,
        separatorBuilder: (_, index) => const Divider(height: 1, color: Colors.grey,),
        itemBuilder: (_, index) {
          return MyExpansion(item: p.phones[index]);
        },
      ),
    );
  }
}
