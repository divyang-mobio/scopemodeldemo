import 'package:flutter/material.dart';
import 'package:googlemapdemo/scope_data.dart';
import 'package:scoped_model/scoped_model.dart';

class LocationList extends StatefulWidget {
  const LocationList({Key? key}) : super(key: key);

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Saved Data'),
      ),

      ///without bloc
      body: ScopedModelDescendant<DataFetch>(
          builder: (constant, child, model) =>
              (model.locationData.isEmpty)
                  ? const Center(child: Text("No Data Found"))
                  : ListView.builder(
                      itemCount: model.locationData.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onDoubleTap: () {
                            model.delete(model.locationData[index].id as int);
                          },
                          child: Card(
                              elevation: 8,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                        "id: ${model.locationData[index].id.toString()}"),
                                  ),
                                  ListTile(
                                    title: Text(
                                        "longitude: ${model.locationData[index].longitude.toString()}"),
                                  ),
                                  ListTile(
                                    title: Text(
                                        "latitude: ${model.locationData[index].latitude.toString()}"),
                                  ),
                                ],
                              )),
                          // ),
                        );
                      }),
          ///Bloc
          // body: BlocConsumer<DatafetchBloc, DatafetchState>(
          //   listener: (context, state) {
          //     if (state is DatafetchLoaded) {
          //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //         duration: const Duration(milliseconds: 600),
          //         content:
          //             Text("${state.data.length.toString()} Only Locations left"),
          //       ));
          //       changecolor = Color.fromRGBO(
          //           Random().nextInt(255),
          //           Random().nextInt(255),
          //           Random().nextInt(255),
          //           Random().nextDouble());
          //     }
          //   },
          //   builder: (context, state) {
          //     if (state is DatafetchInitial) {
          //       return const Center(child: CircularProgressIndicator());
          //     } else if (state is DatafetchLoaded) {
          //       return (state.data.isNotEmpty)
          //           ? ListView.builder(
          //               itemCount: state.data.length,
          //               itemBuilder: (context, index) {
          //                 return GestureDetector(
          //                   onDoubleTap: () {
          //                     BlocProvider.of<DatafetchBloc>(context).add(
          //                         DeleteEvent(id: state.data[index].id as int));
          //                   },
          //                   child: Card(
          //                     color: changecolor,
          //                     elevation: 8,
          //                     child: Column(
          //                       children: [
          //                         ListTile(
          //                           title: Text(
          //                               "id: ${state.data[index].id.toString()}"),
          //                         ),
          //                         ListTile(
          //                           title: Text(
          //                             "longitude: ${state.data[index].longitude.toString()}",
          //                           ),
          //                         ),
          //                         ListTile(
          //                           title: Text(
          //                             "latitude: ${state.data[index].latitude.toString()}",
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 );
          //               })
          //           : const Center(child: Text("No data"));
          //     }
          //     return const Text("Something is not working");
          //   },
          // ),
          ),
    );
  }
}
