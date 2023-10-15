import 'package:flutter/material.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Suppression du compte'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Adresse e-mail',
              ),
            ),
            const SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                _showConfirmationDialog();
              },
              child: const Text('Supprimer mon compte'),
            ),
          ],
        ),
      ),
    );
  }
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Êtes-vous sûr de vouloir supprimer votre compte ? Cette action est irréversible.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteAccount();
                Navigator.pop(context);
                // Afficher un message de succès ou de confirmation ici.
              },
              child: const Text('Confirmer'),
            ),
          ],
        );
      },
    );
  }

  void _deleteAccount() {
    // Ici, vous pouvez ajouter la logique pour supprimer effectivement le compte de l'utilisateur.
    // Par exemple, vous pourriez envoyer une requête au backend pour effectuer la suppression.
    // Assurez-vous de gérer les erreurs et les cas de réussite en conséquence.
    print('Compte supprimé avec succès pour l\'adresse e-mail : ${_emailController.text}');
  }

}