import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
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
  final int pollingInterval = 2;
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
      _checkPayment();
    });
  }

  Future<void> _checkPayment() async {
    print('_checkPayment');
    try {
      var response = await http.post(
        Uri.parse("https://edupay.mricdigital.com/mtn_ci_webhook.php"),
        body: {
          // 'id_user': idUser,
        },
      );
    } catch (e) {
      // Gérez les erreurs lors de la requête HTTP
      print('Erreur lors de la requête HTTP : $e');
    }
  }

  Future<void> _checkPaymentStatus() async {
    try {
      var idUser = _cUser.user.id_user.toString();
      print(idUser);
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
          Get.off(() => const Success());
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
            child: const Text('Annuler le paiement'),
          ),
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
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(
                  height: 20,
                ),
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
                  "Veuillez composer le *133# pour valider votre\npaiement via MTN Mobile Money",
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
