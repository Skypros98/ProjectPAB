import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_inven/model/jenisModel.dart';
import 'package:flutter_inven/model/api.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class dataJenis extends StatefulWidget {
  const dataJenis({super.key});

  @override
  State<dataJenis> createState() => _dataJenisState();
}

class _dataJenisState extends State<dataJenis> {  
  var loading = false;
  final list = [];
  final GlobalKey<RefreshIndicatorState> _refresh = GlobalKey<RefreshIndicatorState>();

  getPref() async {
    _lihatData();
  }

  Future<void> _lihatData() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get(Uri.parse(BaseUrl.urlDataJenis));
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new jenisModel(api['id_jenis'], api['nama_jenis']);
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 41, 69, 91),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                "Data Jenis Barang",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Print("Tambah Jenis");
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 41, 69, 91),
        ),
        body: RefreshIndicator(
          onRefresh: _lihatData,
          key: _refresh,
          child: loading
          ? Center(
              child: Text("Data Kosong"),
            )
          : ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              final x = list[i];
              return Container(
                margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Card(
                  color: const Color.fromARGB(255, 250, 248, 246),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          x.nama_jenis.toString(),
                        ),
                        trailing: Wrap(
                          children: [
                            IconButton(
                              onPressed: () {
                                // edit
                              },
                              icon : Icon(Icons.edit)),
                            IconButton(
                              onPressed: () {
                                // delete
                              },
                              icon: Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
         )),
    
    );
  }
}