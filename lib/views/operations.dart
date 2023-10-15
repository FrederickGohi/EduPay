import 'dart:convert';
import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../api/api.dart';
import '../constantes/constantes.dart';
import '../controllers/c_user.dart';
import '../models/matricule.dart';
import 'Services/get_cantine.dart';
import 'Services/get_extra_scolaire.dart';
import 'Services/get_scolarite.dart';
import 'Services/get_transport.dart';
import 'package:shimmer/shimmer.dart';

class Operation extends StatefulWidget {
  final matricule;
  final naissance;
  const Operation({Key? key, required this.matricule, required this.naissance})
      : super(key: key);

  @override
  State<Operation> createState() => _OperationState();
}

class _OperationState extends State<Operation> {
  Future<List<Matricule>> getStudent() async {
    List<Matricule> listMatricule = [];
    var response = await http.post(
      Uri.parse(Api.checkMatricule),
      body: {
        'matricule': '${widget.matricule}',
        'naissance': '${widget.naissance}',
      },
    );
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        for (var element in (responseBody['data'] as List)) {
          listMatricule.add(Matricule.fromJson(element));
        }
      }
      inspect(responseBody);
    }
    return listMatricule;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CUser(),
        builder: (context_) {
          return Scaffold(
            // backgroundColor: Colors.grey.shade100,
            appBar: AppBar(
              centerTitle: true,
              title: const AutoSizeText(
                "SERVICES",
                // style: GoogleFonts.roboto(
                //     color: Colors.white, fontWeight: FontWeight.bold),
                maxFontSize: 15,
                minFontSize: 14,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            body: SingleChildScrollView(
              child: FutureBuilder(
                future: getStudent(),
                builder: (context, AsyncSnapshot<List<Matricule>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                        //Chargement shimmer
                        baseColor: const Color.fromARGB(255, 212, 208, 208),
                        highlightColor:
                            const Color.fromARGB(255, 253, 250, 250),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                  margin: const EdgeInsets.only(
                                    left: 5.0,
                                  ),
                                  // height: MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.46,
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 255, 0, 0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                  margin: const EdgeInsets.only(
                                    left: 5.0,
                                  ),
                                  // height: MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.50,
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 255, 0, 0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                  margin: const EdgeInsets.only(
                                    left: 5.0,
                                  ),
                                  // height: MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.55,
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 255, 0, 0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                  margin: const EdgeInsets.only(
                                    left: 5.0,
                                  ),
                                  // height: MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.60,
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 255, 0, 0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                  margin: const EdgeInsets.only(
                                    left: 5.0,
                                  ),
                                  // height: MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.66,
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 255, 0, 0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  )),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                              ),
                              Row(
                                //SHimmer images
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(
                                        left: 5.0,
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.22,
                                      width: MediaQuery.of(context).size.width *
                                          0.46,
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        color: Color.fromARGB(255, 255, 0, 0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                        margin: const EdgeInsets.only(
                                          right: 5.0,
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.22,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.46,
                                        padding: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(255, 255, 0, 0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16)),
                                        )),
                                  )
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),
                              Row(
                                //SHimmer images
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(
                                        left: 5.0,
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.22,
                                      width: MediaQuery.of(context).size.width *
                                          0.46,
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        color: Color.fromARGB(255, 255, 0, 0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                        margin: const EdgeInsets.only(
                                          right: 5.0,
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.22,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.46,
                                        padding: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(255, 255, 0, 0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16)),
                                        )),
                                  )
                                ],
                              ),
                            ]));
                  }
                  if (snapshot.data == null) {
                    return const Center(
                      child: Text('Vide'),
                    );
                  }
                  if (snapshot.data!.isNotEmpty) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            // color: Colors.amber,
                            height: MediaQuery.of(context).size.height * 0.9,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                Matricule matricule = snapshot.data![index];
                                return SingleChildScrollView(
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height * 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                            left: Dimensions.MobileMargin,
                                            right: Dimensions.MobileMargin,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Center(
                                                        child: AutoSizeText(
                                                          "Nom:",
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  23),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: AutoSizeText(
                                                          " ${matricule.nom}",
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  23),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.01,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Center(
                                                        child: AutoSizeText(
                                                          "Prénom(s):",
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  23),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: AutoSizeText(
                                                          " ${matricule.prenom}",
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  23),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.01,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Center(
                                                        child: AutoSizeText(
                                                          "Classe: ",
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  23),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: AutoSizeText(
                                                          " ${matricule.classe}",
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  23),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.01,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Center(
                                                        child: AutoSizeText(
                                                          "Date de naissance: ",
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  23),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: AutoSizeText(
                                                          " ${matricule.date_naissance}",
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  23),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.01,
                                                  ),
                                                  // Row(
                                                  //   children: [
                                                  //     Center(
                                                  //       child: AutoSizeText(
                                                  //         "Matricule:",
                                                  //         textAlign:
                                                  //             TextAlign.center,
                                                  //         maxLines: 1,
                                                  //         overflow: TextOverflow
                                                  //             .ellipsis,
                                                  //         style: TextStyle(
                                                  //             fontWeight:
                                                  //                 FontWeight
                                                  //                     .bold,
                                                  //             fontSize: MediaQuery.of(
                                                  //                         context)
                                                  //                     .size
                                                  //                     .width /
                                                  //                 23),
                                                  //       ),
                                                  //     ),
                                                  //     Center(
                                                  //       child: AutoSizeText(
                                                  //         " ${matricule.matricule}",
                                                  //         textAlign:
                                                  //             TextAlign.center,
                                                  //         maxLines: 1,
                                                  //         overflow: TextOverflow
                                                  //             .ellipsis,
                                                  //         style: TextStyle(
                                                  //             color:
                                                  //                 Colors.grey,
                                                  //             fontWeight:
                                                  //                 FontWeight
                                                  //                     .bold,
                                                  //             fontSize: MediaQuery.of(
                                                  //                         context)
                                                  //                     .size
                                                  //                     .width /
                                                  //                 23),
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.01,
                                                  ),
                                                  // Row(
                                                  //   children: [
                                                  //     Center(
                                                  //       child: AutoSizeText(
                                                  //         "Lieu de naissance:",
                                                  //         textAlign:
                                                  //             TextAlign.center,
                                                  //         maxLines: 1,
                                                  //         overflow: TextOverflow
                                                  //             .ellipsis,
                                                  //         style: TextStyle(
                                                  //             fontWeight:
                                                  //                 FontWeight
                                                  //                     .bold,
                                                  //             fontSize: MediaQuery.of(
                                                  //                         context)
                                                  //                     .size
                                                  //                     .width /
                                                  //                 23),
                                                  //       ),
                                                  //     ),
                                                  //     Center(
                                                  //       child: AutoSizeText(
                                                  //         " ${matricule.lieu_naissance}",
                                                  //         textAlign:
                                                  //             TextAlign.center,
                                                  //         maxLines: 1,
                                                  //         overflow: TextOverflow
                                                  //             .ellipsis,
                                                  //         style: TextStyle(
                                                  //             color:
                                                  //                 Colors.grey,
                                                  //             fontWeight:
                                                  //                 FontWeight
                                                  //                     .bold,
                                                  //             fontSize: MediaQuery.of(
                                                  //                         context)
                                                  //                     .size
                                                  //                     .width /
                                                  //                 23),
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.03,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.only(
                                            left: Dimensions.MobileMargin - 10,
                                            right: Dimensions.MobileMargin - 10,
                                          ),
                                          decoration: const BoxDecoration(
                                            // color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(40),
                                              topLeft: Radius.circular(40),
                                            ),
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          var data = {
                                                            'nom': matricule
                                                                .nom, //Map
                                                            'prenom': matricule
                                                                .prenom, //Map
                                                            'classe': matricule
                                                                .classe,
                                                            'date_naissance':
                                                                matricule
                                                                    .date_naissance,
                                                            'matricule':
                                                                matricule
                                                                    .matricule,
                                                            'lieu': matricule
                                                                .lieu_naissance,
                                                            'service':
                                                                'Scolarité',
                                                          };
                                                          Get.to(
                                                              () =>
                                                                  GetScolarite(
                                                                      data:
                                                                          data),
                                                              fullscreenDialog:
                                                                  true);
                                                        },
                                                        child: Card(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0)),
                                                          elevation: 10.0,
                                                          child: Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.2,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.45,
                                                            decoration:
                                                                const BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15)),
                                                              // color:
                                                              //     Colors.white,
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      15.0),
                                                              child: Center(
                                                                child: Column(
                                                                  children: [
                                                                    SizedBox(
                                                                      // margin: const EdgeInsets
                                                                      //         .only(
                                                                      //     top: Dimensions
                                                                      //         .MobileMargin),

                                                                      height:
                                                                          100,
                                                                      width:
                                                                          100,
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/images/paiement_scolarite.png',
                                                                        width:
                                                                            50,
                                                                        height:
                                                                            50,
                                                                      ),
                                                                    ),
                                                                    // SizedBox(
                                                                    //   height: Get
                                                                    //           .height *
                                                                    //       0.01,
                                                                    // ),
                                                                    Text(
                                                                      'Scolarité',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize: MediaQuery.of(context).size.width *
                                                                              0.04,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                    GestureDetector(
                                                        onTap: () {
                                                          var data = {
                                                            'nom': matricule
                                                                .nom, //Map
                                                            'prenom': matricule
                                                                .prenom, //Map
                                                            'classe': matricule
                                                                .classe,
                                                            'date_naissance':
                                                                matricule
                                                                    .date_naissance,
                                                            'matricule':
                                                                matricule
                                                                    .matricule,
                                                            'lieu': matricule
                                                                .lieu_naissance,
                                                            'service':
                                                                'Cantine',
                                                          };
                                                          Get.to(
                                                              () => GetCantine(
                                                                  data: data),
                                                              fullscreenDialog:
                                                                  true);
                                                        },
                                                        child: Card(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0)),
                                                          elevation: 10.0,
                                                          child: Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.2,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.45,
                                                            decoration:
                                                                const BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15)),
                                                              // color:
                                                              //     Colors.white,
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      15.0),
                                                              child: Center(
                                                                child: Column(
                                                                  children: [
                                                                    SizedBox(
                                                                      // margin: const EdgeInsets
                                                                      //         .only(
                                                                      //     top: Dimensions
                                                                      //         .MobileMargin),

                                                                      height:
                                                                          100,
                                                                      width:
                                                                          100,
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/images/paiement_cantine.png',
                                                                        width:
                                                                            50,
                                                                        height:
                                                                            50,
                                                                      ),
                                                                    ),
                                                                    // SizedBox(
                                                                    //   height: Get
                                                                    //           .height *
                                                                    //       0.01,
                                                                    // ),
                                                                    Text(
                                                                      'Cantine',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize: MediaQuery.of(context).size.width *
                                                                              0.04,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.02,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          var data = {
                                                            'nom': matricule
                                                                .nom, //Map
                                                            'prenom': matricule
                                                                .prenom, //Map
                                                            'classe': matricule
                                                                .classe,
                                                            'date_naissance':
                                                                matricule
                                                                    .date_naissance,
                                                            'matricule':
                                                                matricule
                                                                    .matricule,
                                                            'lieu': matricule
                                                                .lieu_naissance,
                                                            'service':
                                                                'Transport',
                                                          };
                                                          Get.to(
                                                              () =>
                                                                  GetTransport(
                                                                      data:
                                                                          data),
                                                              fullscreenDialog:
                                                                  true);
                                                        },
                                                        child: Card(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0)),
                                                          elevation: 10.0,
                                                          child: Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.2,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.45,
                                                            decoration:
                                                                const BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15)),
                                                              // color:
                                                              //     Colors.white,
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      15.0),
                                                              child: Center(
                                                                child: Column(
                                                                  children: [
                                                                    SizedBox(
                                                                      // margin: const EdgeInsets
                                                                      //         .only(
                                                                      //     top: Dimensions
                                                                      //         .MobileMargin),

                                                                      height:
                                                                          100,
                                                                      width:
                                                                          100,
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/images/paiement_transport.png',
                                                                        width:
                                                                            50,
                                                                        height:
                                                                            50,
                                                                      ),
                                                                    ),
                                                                    // SizedBox(
                                                                    //   height: Get
                                                                    //           .height *
                                                                    //       0.01,
                                                                    // ),
                                                                    Text(
                                                                      'Transport',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize: MediaQuery.of(context).size.width *
                                                                              0.04,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                    GestureDetector(
                                                        onTap: () {
                                                          var data = {
                                                            'nom': matricule
                                                                .nom, //Map
                                                            'prenom': matricule
                                                                .prenom, //Map
                                                            'classe': matricule
                                                                .classe,
                                                            'date_naissance':
                                                                matricule
                                                                    .date_naissance,
                                                            'matricule':
                                                                matricule
                                                                    .matricule,
                                                            'lieu': matricule
                                                                .lieu_naissance,
                                                            'service':
                                                                'Extra Scolaire',
                                                          };
                                                          Get.to(
                                                              () =>
                                                                  ExtraScolaire(
                                                                      data:
                                                                          data),
                                                              fullscreenDialog:
                                                                  true);
                                                        },
                                                        child: Card(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0)),
                                                          elevation: 10.0,
                                                          child: Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.2,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.45,
                                                            decoration:
                                                                const BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15)),
                                                              // color:
                                                              //     Colors.white,
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      15.0),
                                                              child: Center(
                                                                child: Column(
                                                                  children: [
                                                                    SizedBox(
                                                                      // margin: const EdgeInsets
                                                                      //         .only(
                                                                      //     top: Dimensions
                                                                      //         .MobileMargin),

                                                                      height:
                                                                          100,
                                                                      width:
                                                                          100,
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/images/sports.png',
                                                                        width:
                                                                            50,
                                                                        height:
                                                                            50,
                                                                      ),
                                                                    ),
                                                                    // SizedBox(
                                                                    //   height: Get
                                                                    //           .height *
                                                                    //       0.01,
                                                                    // ),
                                                                    Text(
                                                                      'Extra Scolaire',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize: MediaQuery.of(context).size.width *
                                                                              0.04,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          )
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                        child: Text("Ce numéro matricule n'est pas reconnu"));
                  }
                },
              ),
            ),
          );
        });
  }
}
