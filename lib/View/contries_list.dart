import 'package:covid19/Services/states_services.dart';
import 'package:flutter/material.dart';
class ContriesListScreen extends StatefulWidget {
  const ContriesListScreen({super.key});

  @override
  State<ContriesListScreen> createState() => _ContriesListScreenState();
}

class _ContriesListScreenState extends State<ContriesListScreen> {
  TextEditingController searchController=TextEditingController();
  StatesServices statesServices=StatesServices();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 50),
                  hintText: 'Search with country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)
                  )
                ),

              ),
            ),
            Expanded(
                child: FutureBuilder(
                  future: statesServices.countriesListApi(),
                  builder: (context,AsyncSnapshot<List<dynamic>> snapshot) {
                    if(snapshot.hasData){
                      return Text('loading');
                    }else{
                      return ListView.builder(
                        itemCount:snapshot.data!.length ,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                leading: Image(
                                    image: NetworkImage(
                                      snapshot.data?[index]['countryInfo']['flag']

                                )),
                              )
                            ],
                          );
                        },);
                    }


                },)
            )
          ],
        ),
      ),
    );
  }
}
