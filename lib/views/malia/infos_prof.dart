import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../api/api.dart';
import '../../constantes/constantes.dart';
import '../../models/profs.dart';

class InfoProf extends StatefulWidget {
  const InfoProf({super.key});

  @override
  State<InfoProf> createState() => _InfoProfState();
}

class _InfoProfState extends State<InfoProf> {
  Future<List<Profs>> _getProfs() async {
    List<Profs> listProfs = [];
    var response = await http.post(
      Uri.parse(Api.getProfs),
      body: {
        // 'classe': widget.classe.toString(),
      },
    );
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        for (var element in (responseBody['data'] as List)) {
          listProfs.add(Profs.fromJson(element));
        }
      }
      // inspect(responseBody);
    }
    return listProfs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enseignants'),
      ),
      body: Center(
        child: _buildProf(),
      ),
    );
  }

  Widget _buildProf() {
    return FutureBuilder<List<dynamic>>(
      future: _getProfs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List? data = snapshot.data;
          return ListView.builder(
            itemCount: data!.length,
            itemBuilder: (context, index) {
              Profs profs = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  elevation: 8.0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.32,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      // color: Couleurs.EndCouleur,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                // color: Couleurs.ButtonCouleur,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.01),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.personCircleCheck,
                                      size: 22,
                                    ),
                                  ),
                                  title: Column(
                                    children: [
                                      Text(
                                        "${profs.nom} ${profs.prenom}",
                                        style: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        profs.matiere,
                                        style: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 17),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                child: Container(
                              height: MediaQuery.of(context).size.height * 0.04,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Couleurs.ButtonCouleur,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        child: FaIcon(
                                          FontAwesomeIcons.envelopeOpenText,
                                          size: 22,
                                        ),
                                      ),
                                      title: Text(
                                        'Email',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                      subtitle: Text(
                                        profs.email,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.white,
                                    ),
                                    ListTile(
                                      leading: CircleAvatar(
                                        child: FaIcon(
                                          FontAwesomeIcons.phone,
                                          size: 22,
                                        ),
                                      ),
                                      title: Text(
                                        'Téléphone',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                      subtitle: Text(
                                        profs.telephone,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Failed to load data from API'),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
