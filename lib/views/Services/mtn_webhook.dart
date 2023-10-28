import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
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
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startCountdown();
    });
  }

  void _startCountdown() {
    // Démarrez un délai de 05 secondes pour la redirection
    Future.delayed(const Duration(seconds: 5), () {
      // Redirigez l'utilisateur vers la page Success
      Get.off(() => const Success());
    });
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
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
