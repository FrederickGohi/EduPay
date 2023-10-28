import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/c_user.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  final _cUser = Get.put(CUser());

  @override
  void initState() {
    super.initState();
  }

  Future<void> openWhatsappSuppport() async {
    var whatsappTel = "+2250566223400";

    Uri whatsappURlAndroid = Uri.parse(
        "https://wa.me/$whatsappTel?text=${Uri.parse("Bonjour, Pouvez-vous m'aider svp ? mon nom c'est ${_cUser.user.nom} ${_cUser.user.prenom}")}");
    var whatappURLIos = Uri.parse(
        "https://wa.me/$whatsappTel?text=${Uri.parse("Bonjour, Pouvez-vous m'aider svp ? mon nom c'est ${_cUser.user.nom} ${_cUser.user.prenom}")}");
    if (Platform.isIOS) {
      // for iOS phone only
      if (!await launchUrl(
        whatappURLIos,
        mode: LaunchMode.externalApplication,
      )) {
        await launchUrl(whatappURLIos);
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("WhatsApp n'est pas installé")));
      }
    } else {
      // android , web
      if (!await launchUrl(
        whatsappURlAndroid,
        mode: LaunchMode.externalApplication,
      )) {
        await launchUrl(whatsappURlAndroid);
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("WhatsApp n'est pas installé")));
      }
    }
  }

  Future<void> _launchTel() async {
    final Uri url = Uri.parse('tel:+2250566223400');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchMail() async {
    final Uri _url = Uri.parse(
        "mailto:contact@edupay.com?subject=Demande d'assistance&body=Bonjour ");
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> _launchRating() async {
    final Uri url = Uri.parse(
        "https://play.google.com/store/apps/details?id=com.lkmdigital.liapay&pli=1");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchFeedback() async {
    final Uri url = Uri.parse(
        "mailto:infos@lkmdigital.ci?subject=FeedBack LIA-PAY [${_cUser.user.telephone}]&");
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchFacebook() async {
    final Uri url = Uri.parse("https://www.facebook.com/LKMDIGITAL");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchLinkedin() async {
    final Uri url = Uri.parse("https://www.linkedin.com/company/lkm-digital");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchWhatsapp() async {
    var whatsappTel = "+2250757838498";
    Uri whatsappURlAndroid =
        Uri.parse("https://wa.me/$whatsappTel?text=${Uri.parse("Bonjour, ")}");
    var whatappURLIos =
        Uri.parse("https://wa.me/$whatsappTel?text=${Uri.parse("Bonjour, ")}");
    if (Platform.isIOS) {
      // for iOS phone only
      if (!await launchUrl(
        whatappURLIos,
        mode: LaunchMode.externalApplication,
      )) {
        await launchUrl(whatappURLIos);
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("WhatsApp n'est pas installé")));
      }
    } else {
      // android , web
      if (!await launchUrl(
        whatsappURlAndroid,
        mode: LaunchMode.externalApplication,
      )) {
        await launchUrl(whatsappURlAndroid);
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("WhatsApp n'est pas installé")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder(
        init: CUser(),
        builder: (context) {
          return Scaffold(
            floatingActionButton: Container(
                height: MediaQuery.of(this.context).size.height * 0.055,
                width: MediaQuery.of(this.context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Theme.of(this.context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20.0),
                  border: const Border.fromBorderSide(BorderSide.none),
                ),
                child: InkWell(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        "Propulsé par MetaTech",
                        style: Theme.of(this.context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                "Service Support",
                style: Theme.of(this.context).textTheme.titleLarge,
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          "Support 24h/7",
                          style: Theme.of(this.context).textTheme.titleMedium,
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Card(
                          elevation: 8.0,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: const BoxDecoration(

                                // color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(17))),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    openWhatsappSuppport();
                                  },
                                  child: ListTile(
                                    leading: const CircleAvatar(
                                      backgroundColor: Colors.green,
                                      child: FaIcon(
                                        FontAwesomeIcons.whatsapp,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Assistance via WhatsApp',
                                          style: Theme.of(this.context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                        Text(
                                          "⚡️Réponses rapides 24h/24",
                                          style: Theme.of(this.context)
                                              .textTheme
                                              .bodyMedium,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.015,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _launchTel();
                                  },
                                  child: ListTile(
                                    leading: const CircleAvatar(
                                      child: FaIcon(
                                        FontAwesomeIcons.phoneVolume,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '+225 05 66 22 34 00',
                                          style: Theme.of(this.context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                        Text(
                                          "Nous joindre par téléphone",
                                          style: Theme.of(this.context)
                                              .textTheme
                                              .bodyMedium,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.015,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _launchMail();
                                  },
                                  child: ListTile(
                                    leading: const CircleAvatar(
                                      child: FaIcon(
                                        FontAwesomeIcons.envelope,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AutoSizeText(
                                          'contact@edupay.com',
                                          style: Theme.of(this.context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                        AutoSizeText(
                                          "Nous joindre par mail",
                                          style: Theme.of(this.context)
                                              .textTheme
                                              .bodyMedium,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        AutoSizeText(
                          "Feedback",
                          style: Theme.of(this.context).textTheme.titleMedium,
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Card(
                          elevation: 8.0,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: const BoxDecoration(

                                // color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(17))),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // _launchFeedback();
                                  },
                                  child: ListTile(
                                    leading: const CircleAvatar(
                                      child: FaIcon(
                                        FontAwesomeIcons.bug,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AutoSizeText(
                                          'Signaler un bug ou Suggestions',
                                          style: Theme.of(this.context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                        AutoSizeText(
                                          "Signalez nous un problème technique",
                                          style: Theme.of(this.context)
                                              .textTheme
                                              .bodyMedium,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.015,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // _launchRating();
                                  },
                                  child: ListTile(
                                    leading: const CircleAvatar(
                                        child: Icon(
                                      Icons.star_border,
                                      color: Colors.white,
                                      size: 20,
                                    )),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AutoSizeText(
                                          "Noter l'application",
                                          style: Theme.of(this.context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                        AutoSizeText(
                                          "Donnez votre avis sur l'App",
                                          style: Theme.of(this.context)
                                              .textTheme
                                              .bodyMedium,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        AutoSizeText(
                          "Suivez-nous",
                          style: Theme.of(this.context).textTheme.titleMedium,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    // _launchFacebook();
                                  },
                                  child: Container(
                                    height: size.height * 0.1,
                                    width: size.width * 0.2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/icons/facebook.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                const AutoSizeText('Facebook')
                              ],
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // _launchLinkedin();
                                  },
                                  child: Container(
                                    height: size.height * 0.1,
                                    width: size.width * 0.2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/icons/linkedin.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                const AutoSizeText('LinkedIn')
                              ],
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // _launchWhatsapp();
                                  },
                                  child: Container(
                                    height: size.height * 0.1,
                                    width: size.width * 0.2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/icons/whatsapp.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                const AutoSizeText('WhatsApp')
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.1,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
