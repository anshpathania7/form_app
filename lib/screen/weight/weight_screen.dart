import 'package:flutter/material.dart';
import 'package:form_app/provider/auth_provider.dart';
import 'package:form_app/provider/weight_provider.dart';
import 'package:form_app/screen/weight/widgets/enter_weight_dialog_card.dart';
import 'package:form_app/screen/weight/widgets/weight_entries_listview.dart';
import 'package:provider/provider.dart';

class WeightScreen extends StatelessWidget {
  const WeightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeightProvider()..loadAllWeightEntries(),
      child: Consumer<WeightProvider>(
        builder: (context, state, child) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text("Weight Tracker"),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                context.read<AuthProvider>().logoutCurrentUser();
              },
              icon: const Icon(Icons.logout),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) => EnterWeightDialogCard(provider: state),
              );
            },
          ),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: (state.allWeightEntries.isEmpty && !state.isLoading)
                ? const Center(
                    child: Text(
                      "Add a weight",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        WeightEntriesListview(
                          weights: state.allWeightEntries,
                          provider: state,
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
