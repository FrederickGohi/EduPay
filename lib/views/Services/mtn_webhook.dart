import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../../api/api.dart';
import '../../controllers/c_user.dart';
import '../../widgets/root.dart';
import 'success.dart';

class AwaitWebhook extends StatefulWidget {
  const AwaitWebhook({Key? key}) : super(key: key);

  @override
  State<AwaitWebhook> createState() => _AwaitWebhookState();
}

class _AwaitWebhookState extends State<AwaitWebhook> {
  final _cUser = Get.put(CUser());
  final int pollingInterval = 5;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startPolling();
    });
  }

  void _startPolling() {
    // Arrêtez le timer s'il était déjà en cours
    _timer?.cancel();
    // Démarrez un nouveau timer
    _timer = Timer.periodic(Duration(seconds: pollingInterval), (timer) {
      _checkPaymentStatus();
    });
  }

  Future<void> _checkPaymentStatus() async {
    try {
      var idUser = _cUser.user.id_user.toString();
      var response = await http.post(
        Uri.parse(Api.getMtnCiWebhookStatus),
        body: {
          'id_user': idUser,
        },
      );

      if (response.statusCode == 200) {
        inspect(response.body);
        var responseBody = jsonDecode(response.body);
        print(responseBody['paid']);
        // Vérifiez si le paiement a réussi
        if (responseBody['paid']) {
          // Arrêtez le timer car le paiement a réussi
          _timer?.cancel();

          // Redirigez l'utilisateur vers la page de succès
          Get.to(() => const Success());
          print('redirection sur la page success');
        }
      }
    } catch (e) {
      // Gérez les erreurs lors de la requête HTTP
      print('Erreur lors de la requête HTTP : $e');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CUser>(
      init: CUser(),
      builder: (context) {
        return Scaffold(
          floatingActionButton: TextButton(
              onPressed: () {
                Get.offAll(() => const Root());
              },
              child: const Text('Annuler le paiement')),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          appBar: AppBar(
            title: const Text('Paiement en cours'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/mtn_momo.png'),
                  radius: 30,
                  backgroundColor: Colors.amber,
                ),
                const SizedBox(
                  height: 20,
                ),
                // const CircleAvatar(child: Image(image: AssetImage('assets/images/mtn_momo.png')),),

                // Container(
                //           height: 60,
                //           width: 60,
                //           decoration: BoxDecoration(
                //             color: Colors.amber,
                //             borderRadius: BorderRadius.circular(30),
                //             image: const DecorationImage(
                //               image: AssetImage('assets/images/mtn_momo.png'),
                //               fit: BoxFit.fill,
                //             ),
                //           ),
                //         ),
                Text(
                  "Paiement via MTN CI en cours ...",
                  style: Theme.of(this.context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Nous avons juste besoin de votre confirmation",
                  style: Theme.of(this.context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 20,
                ),
                const CircularProgressIndicator(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Veuillez composer le *133# pour valider votre\n paiement via MTN Mobile Money",
                  style: Theme.of(this.context).textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
