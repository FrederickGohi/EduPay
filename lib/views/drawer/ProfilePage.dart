import 'package:auto_size_text/auto_size_text.dart';
import 'package:edupay/login_register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../constantes/constantes.dart';
import '../../constantes/metierCore.dart';
import '../../controllers/c_user.dart';
import '../Services/support.dart';
import '../login/login.dart';
import '../../widgets/event_pref.dart';
import 'delete_account.dart';
import 'privacy_policy.dart';

class ProfilPage extends StatefulWidget {
  ProfilPage({Key? key}) : super(key: key);
  @override
  _ProfilPage createState() => _ProfilPage();
}

class _ProfilPage extends State<ProfilPage> {
  int index = 0;
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomsController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  List<Widget> formUpdate = [];
  //================ sliding up
  final PanelController _pc = new PanelController();
  final ScrollController _sc = new ScrollController();
  double? _panelHeightOpen;
  final double _panelHeightClosed = 0.0;
  bool sliding = false;
  //================ sliding up
  bool isPhone = false;
  bool isNom = false;
  bool isEmail = false;
  bool isPrenoms = false;
  bool isPassword = false;
  bool isCode = false;
  bool isObscurityText = true;

  final _cUser = Get.put(CUser());

  @override
  void initState() {
    super.initState();
  }

  void logout() async {
    // apres deconnexion
    var response = await Get.dialog(
      AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Vous êtes sur le point de vous déconnecter'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Annuler')),
          TextButton(
              onPressed: () => Get.back(result: 'Déconnexion'),
              child: const Text('Déconnexion')),
        ],
      ),
    );
    if (response == 'Déconnexion') {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });

      Future.delayed(const Duration(milliseconds: 1500), () {
        EventPref.deleteUser().then((value) {
          Get.offAll(() => const Login());
        });
      });
    }
  }

  void setSlidingUpHeight(Size size, double dim) {
    setState(() {
      _panelHeightOpen = size.height * dim;
    });
  }

  void initialisedListeForm(Size size) {
    setState(() {
      formUpdate = [
        updateNom(context, size, _sc),
        updatePrenoms(context, size, _sc),
        updateEmail(context, size, _sc),
        updateContact(context, size, _sc),
        updatePassword(context, size, _sc),
      ];
    });
  }

  void openSlidingUp() async {
    setState(() {
      sliding = true;
    });
    _pc.open();
  }

  void closeSlidingUp() {
    _pc.close();
    setState(() {
      sliding = false;
    });
  }

  void nomUpdateForm() async {
    setState(() {
      index = 0;
      _nomController.text = _cUser.user.nom;
    });
    openSlidingUp();
  }

  void prenomUpdateForm() async {
    setState(() {
      index = 1;
      _prenomsController.text = _cUser.user.prenom;
    });
    openSlidingUp();
  }

  void emailUpdateForm() async {
    setState(() {
      index = 2;
      _emailController.text = _cUser.user.email;
    });
    openSlidingUp();
  }

  void phoneUpdateForm() async {
    setState(() {
      index = 3;
      _phoneController.text = _cUser.user.telephone;
    });
    openSlidingUp();
  }

  void passwordUpdateForm() async {
    setState(() {
      index = 4;
    });
    openSlidingUp();
  }

  showConfirmLogout() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        message: const Text("Voulez-vous vous déconnecter ?"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  });

              Future.delayed(const Duration(milliseconds: 1500), () {
                EventPref.deleteUser().then((value) {
                  Get.offAll(() => const LoginRegister());
                });
              });
            },
            child: const Text(
              "Déconnexion",
              style: TextStyle(color: Colors.red),
            ),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text(
            "Annuler",
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    setSlidingUpHeight(size, 0.235);
    initialisedListeForm(size);
    return GetBuilder(
      init: CUser(),
      builder: (context_) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "Mon profil",
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 8.0,
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(17))),
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(
                                Icons.person,
                                size: 25,
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  size: 25,
                                ),
                                onPressed: () {
                                  nomUpdateForm();
                                },
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nom',
                                    style: Theme.of(this.context)
                                        .textTheme
                                        .titleLarge,
                                  ),
                                  Text(
                                    _cUser.user.nom,
                                    style: Theme.of(this.context)
                                        .textTheme
                                        .titleMedium,
                                  )
                                ],
                              ),
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.person,
                                size: 25,
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  size: 25,
                                ),
                                onPressed: () {
                                  prenomUpdateForm();
                                },
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Prénom(s)',
                                    style: Theme.of(this.context)
                                        .textTheme
                                        .titleLarge,
                                  ),
                                  Text(
                                    _cUser.user.prenom,
                                    style: Theme.of(this.context)
                                        .textTheme
                                        .titleMedium,
                                  )
                                ],
                              ),
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.email,
                                size: 25,
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  size: 25,
                                ),
                                onPressed: () {
                                  emailUpdateForm();
                                },
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Email',
                                    style: Theme.of(this.context)
                                        .textTheme
                                        .titleLarge,
                                  ),
                                  Text(
                                    _cUser.user.email,
                                    style: Theme.of(this.context)
                                        .textTheme
                                        .titleMedium,
                                  )
                                ],
                              ),
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.phone,
                                size: 25,
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Contact',
                                    style: Theme.of(this.context)
                                        .textTheme
                                        .titleLarge,
                                  ),
                                  Text(
                                    _cUser.user.telephone,
                                    style: Theme.of(this.context)
                                        .textTheme
                                        .titleMedium,
                                  )
                                ],
                              ),
                              trailing: const Icon(Icons.edit),
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const Support());
                      },
                      child: Card(
                        elevation: 8.0,
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              // color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(17))),
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(
                                Icons.headphones,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              'Support technique',
                              style:
                                  Theme.of(this.context).textTheme.titleLarge,
                            ),
                            trailing: const Icon(Icons.chevron_right),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Forward();
                      },
                      child: Card(
                        elevation: 8.0,
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              // color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(17))),
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(
                                Icons.share,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              'Inviter un ami',
                              style:
                                  Theme.of(this.context).textTheme.titleLarge,
                            ),
                            trailing: const Icon(Icons.chevron_right),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Card(
                      elevation: 8.0,
                      child: InkWell(
                        onTap: () {
                          Get.to(() => const PrivacyPolicy());
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              // color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(17))),
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(
                                Icons.shield_outlined,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              'Confidentialité',
                              style:
                                  Theme.of(this.context).textTheme.titleLarge,
                            ),
                            trailing: const Icon(Icons.chevron_right),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Card(
                      elevation: 8.0,
                      child: InkWell(
                        onTap: () {
                          Get.to(() => const DeleteAccount());
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              // color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(17))),
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(
                                Icons.delete,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              'Supprimer mon compte',
                              style:
                                  Theme.of(this.context).textTheme.titleLarge,
                            ),
                            trailing: const Icon(Icons.chevron_right),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Card(
                      elevation: 8.0,
                      child: InkWell(
                        onTap: () {
                          // logout();
                          showConfirmLogout();
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              // color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(17))),
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(
                                Icons.logout,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              'Déconnexion',
                              style:
                                  Theme.of(this.context).textTheme.titleLarge,
                            ),
                            trailing: const Icon(Icons.chevron_right),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget updateNom(context, Size size, ScrollController sc) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(
          right: Dimensions.MobileMargin,
          left: Dimensions.MobileMargin,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.MobileMargin,
          vertical: Dimensions.MobileMargin - 10,
        ),
        decoration: const BoxDecoration(
            // color: Colors.white,
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Modifiez Son Nom",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.MobileMargin - 10,
                vertical: Dimensions.MobileMargin - 18,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                border: Border.all(
                  color: Couleurs.ButtonCouleur,
                  width: 1,
                ),
              ),
              child: TextFormField(
                controller: _nomController,
                onChanged: (txt) {
                  setState(() {
                    isNom = Validator.name(txt);
                  });
                },
                onEditingComplete: () {
                  setState(() {
                    _nomController.text = _nomController.text.toString().trim();
                    isNom = Validator.name(_nomController.text);
                  });
                },
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Ex: KOUASSI',
                  filled: false,
                  labelStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Couleurs.ButtonCouleur,
                    ),
                    onPressed: () {
                      setState(() {
                        _nomController.clear();
                      });
                    },
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 40.0,
              decoration: BoxDecoration(
                // color: Colors.black,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(
                  color: Couleurs.ButtonCouleur,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40.0,
                    width: size.width * 0.4,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      border: Border.fromBorderSide(BorderSide.none),
                    ),
                    child: InkWell(
                      onTap: () {
                        closeSlidingUp();
                      },
                      child: const Center(
                        child: AutoSizeText(
                          "ANNULER",
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40.0,
                    width: size.width * 0.37,
                    decoration: BoxDecoration(
                      color: isNom ? Couleurs.EndCouleur : Colors.grey.shade300,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      border: const Border.fromBorderSide(BorderSide.none),
                    ),
                    child: InkWell(
                      onTap: isNom ? () {} : null,
                      child: Center(
                        child: AutoSizeText(
                          "VALIDER",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: isNom ? Colors.white : Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget updatePrenoms(context, Size size, ScrollController sc) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(
          right: Dimensions.MobileMargin,
          left: Dimensions.MobileMargin,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.MobileMargin,
          vertical: Dimensions.MobileMargin - 10,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Modifiez Son Prénom(s)",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.MobileMargin - 10,
                vertical: Dimensions.MobileMargin - 18,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                border: Border.all(
                  color: Couleurs.ButtonCouleur,
                  width: 1,
                ),
              ),
              child: TextFormField(
                controller: _prenomsController,
                onChanged: (txt) {
                  setState(() {
                    isPrenoms = Validator.name(txt);
                  });
                },
                onEditingComplete: () {
                  setState(() {
                    _prenomsController.text =
                        _prenomsController.text.toString().trim();
                    isPrenoms = Validator.name(_prenomsController.text);
                  });
                },
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Ex: Yves Junior',
                  filled: false,
                  labelStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Couleurs.ButtonCouleur,
                    ),
                    onPressed: () {
                      setState(() {
                        _prenomsController.clear();
                      });
                    },
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(
                  color: Couleurs.ButtonCouleur,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 40.0,
                    width: size.width * 0.4,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      border: Border.fromBorderSide(BorderSide.none),
                    ),
                    child: InkWell(
                      onTap: () {
                        closeSlidingUp();
                      },
                      child: const Center(
                        child: AutoSizeText(
                          "ANNULER",
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40.0,
                    width: size.width * 0.37,
                    decoration: BoxDecoration(
                      color: isPrenoms
                          ? Couleurs.EndCouleur
                          : Colors.grey.shade300,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      border: const Border.fromBorderSide(BorderSide.none),
                    ),
                    child: InkWell(
                      onTap: isPrenoms ? () {} : null,
                      child: Center(
                        child: AutoSizeText(
                          "VALIDER",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: isPrenoms ? Colors.white : Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget updateEmail(context, Size size, ScrollController sc) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(
          right: Dimensions.MobileMargin,
          left: Dimensions.MobileMargin,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.MobileMargin,
          vertical: Dimensions.MobileMargin - 10,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Modifiez Son E-mail",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.MobileMargin - 10,
                vertical: Dimensions.MobileMargin - 18,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                border: Border.all(
                  color: Couleurs.ButtonCouleur,
                  width: 1,
                ),
              ),
              child: TextFormField(
                controller: _emailController,
                onChanged: (txt) {
                  setState(() {
                    isEmail = Validator.email(txt);
                  });
                },
                onEditingComplete: () {
                  setState(() {
                    _emailController.text =
                        _emailController.text.toString().trim();
                    isEmail = Validator.email(_emailController.text);
                  });
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Ex: abc@exemple.ci',
                  filled: false,
                  labelStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Couleurs.ButtonCouleur,
                    ),
                    onPressed: () {
                      setState(() {
                        _emailController.clear();
                      });
                    },
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(
                  color: Couleurs.ButtonCouleur,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 40.0,
                    width: size.width * 0.4,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      border: Border.fromBorderSide(BorderSide.none),
                    ),
                    child: InkWell(
                      onTap: () {
                        closeSlidingUp();
                      },
                      child: const Center(
                        child: AutoSizeText(
                          "ANNULER",
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40.0,
                    width: size.width * 0.37,
                    decoration: BoxDecoration(
                      color:
                          isEmail ? Couleurs.EndCouleur : Colors.grey.shade300,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      border: const Border.fromBorderSide(BorderSide.none),
                    ),
                    child: InkWell(
                      onTap: isEmail ? () {} : null,
                      child: Center(
                        child: AutoSizeText(
                          "VALIDER",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: isEmail ? Colors.white : Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget updateContact(context, Size size, ScrollController sc) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(
          right: Dimensions.MobileMargin,
          left: Dimensions.MobileMargin,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.MobileMargin,
          vertical: Dimensions.MobileMargin - 10,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Modifiez Son Contact",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.MobileMargin - 10,
                vertical: Dimensions.MobileMargin - 18,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                border: Border.all(
                  color: Couleurs.ButtonCouleur,
                  width: 1,
                ),
              ),
              child: TextFormField(
                controller: _phoneController,
                onChanged: (txt) {
                  setState(() {
                    isPhone = Validator.phone(txt);
                  });
                },
                onEditingComplete: () {
                  setState(() {
                    _phoneController.text =
                        _phoneController.text.toString().trim();
                    isPhone = Validator.phone(_phoneController.text);
                  });
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Ex: 0708091011',
                  filled: false,
                  labelStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Couleurs.ButtonCouleur,
                    ),
                    onPressed: () {
                      setState(() {
                        _phoneController.clear();
                      });
                    },
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(
                  color: Couleurs.ButtonCouleur,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 40.0,
                    width: size.width * 0.4,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      border: Border.fromBorderSide(BorderSide.none),
                    ),
                    child: InkWell(
                      onTap: () {
                        closeSlidingUp();
                      },
                      child: const Center(
                        child: AutoSizeText(
                          "ANNULER",
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40.0,
                    width: size.width * 0.37,
                    decoration: BoxDecoration(
                      color:
                          isPhone ? Couleurs.EndCouleur : Colors.grey.shade300,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      border: const Border.fromBorderSide(BorderSide.none),
                    ),
                    child: InkWell(
                      onTap: isPhone ? () {} : null,
                      child: Center(
                        child: AutoSizeText(
                          "VALIDER",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: isPhone ? Colors.white : Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget updatePassword(context, Size size, ScrollController sc) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(
          right: Dimensions.MobileMargin,
          left: Dimensions.MobileMargin,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.MobileMargin,
          vertical: Dimensions.MobileMargin - 10,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Modifiez Son Mot de passe",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.MobileMargin - 10,
                vertical: Dimensions.MobileMargin - 18,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                border: Border.all(
                  color: Couleurs.ButtonCouleur,
                  width: 1,
                ),
              ),
              child: TextFormField(
                controller: _passwordController,
                onChanged: (txt) {
                  setState(() {
                    isPassword = Validator.password(txt);
                  });
                },
                obscureText: isObscurityText,
                decoration: InputDecoration(
                  hintText: 'Ex: ******',
                  filled: false,
                  labelStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                  suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscurityText = !isObscurityText;
                          });
                        },
                        icon: Visibility(
                          visible: isObscurityText,
                          replacement: const Icon(
                            Icons.visibility_off,
                            color: Couleurs.ButtonCouleur,
                          ),
                          child: const Icon(
                            Icons.remove_red_eye_outlined,
                            color: Couleurs.ButtonCouleur,
                          ),
                        ),
                      )),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(
                  color: Couleurs.ButtonCouleur,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 40.0,
                    width: size.width * 0.4,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      border: Border.fromBorderSide(BorderSide.none),
                    ),
                    child: InkWell(
                      onTap: () {
                        closeSlidingUp();
                      },
                      child: const Center(
                        child: AutoSizeText(
                          "ANNULER",
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40.0,
                    width: size.width * 0.37,
                    decoration: BoxDecoration(
                      color: isPassword
                          ? Couleurs.EndCouleur
                          : Colors.grey.shade300,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      border: const Border.fromBorderSide(BorderSide.none),
                    ),
                    child: InkWell(
                      onTap: isPassword ? () {} : null,
                      child: Center(
                        child: AutoSizeText(
                          "VALIDER",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: isPassword ? Colors.white : Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
