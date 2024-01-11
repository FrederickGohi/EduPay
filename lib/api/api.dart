class Api {
  static const _host = 'https://edupay.mricdigital.com/api/v1';

  static const pay = 'https://edupay.mricdigital.com/OnlinePaymentService/add_payer';


  static const _hostArticles = '$_host/articles';
  static const _hostecoles = '$_host/ecoles';
  static const _hosteclasses = '$_host/classes';
  static const _hostUser = '$_host/user';
  static const _hostPaiements = '$_host/paiements';


  static const addArticles = '$_hostArticles/add.php';
  static const getAll = '$_hostecoles/get_all.php';
  static const getAll1 = '$_hosteclasses/get_all.php';
  static const getScolarite = '$_hosteclasses/get_scolarite.php';
  static const getCantine = '$_hosteclasses/get_cantine.php';
  static const getTransport = '$_hosteclasses/get_transport.php';
  static const getExtra = '$_hosteclasses/get_extra.php';
  static const checkMatricule = '$_hosteclasses/check_matricule.php';

  static const getExamens = '$_hosteclasses/get_examens.php';
  static const getDevoirs = '$_hosteclasses/get_devoirs.php';
  static const getProfs = '$_hosteclasses/get_profs.php';


    // Articles
  // static const searchShoes = '$_hostShoes/search.php';
  static const getEnfant = '$_hostPaiements/get_enfants.php';
  static const getAllPayment = '$_hostPaiements/get_all.php';
  static const getLastPayment = '$_hostPaiements/last_payment.php';
  static const getMtnCiWebhookStatus = '$_hostPaiements/mtn_ci_webhook.php';



  // User
  static const checkEmail = '$_hostUser/check_email.php';
  static const login = '$_hostUser/login.php';
  static const register = '$_hostUser/register.php';
  static const google = '$_hostUser/google.php';
  static const wave = '$_hostUser/google.php';

    static const passwordRecovery = '$_hostUser/password_recovery.php';
  static const newPassword = '$_hostUser/new_password.php';


}
