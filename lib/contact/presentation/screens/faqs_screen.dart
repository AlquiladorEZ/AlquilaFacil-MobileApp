import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../public/presentation/widgets/screen_bottom_app_bar.dart';
import '../../../public/ui/providers/theme_provider.dart';
import '../../../public/ui/theme/main_theme.dart';

class FaqsScreen extends StatelessWidget {
  const FaqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: MainTheme.background(context),
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkTheme
            ? MainTheme.primary(context)
            : MainTheme.background(context),
        title: Text(
          'Preguntas frecuentes',
          style: TextStyle(color: MainTheme.contrast(context)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/search-space');
          },
        ),
      ),
      bottomNavigationBar: const ScreenBottomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            FAQTile(
              question: "¿Cómo reservo un espacio?",
              answer:
              "Primero debes iniciar sesión, seleccionar el espacio deseado y completar la información de reserva (fecha y horario). Luego deberás realizar el depósito al número de cuenta indicado y subir el comprobante de pago para su validación.",
            ),
            FAQTile(
              question: "¿Qué sucede después de subir el comprobante de pago?",
              answer:
              "El propietario del espacio validará el comprobante. Si todo es correcto, la reserva quedará confirmada. En caso de problemas o fraude, el propietario puede rechazarla.",
            ),
            FAQTile(
              question: "¿AlquilaFácil gestiona el dinero o reembolsa pagos?",
              answer:
              "No. AlquilaFácil no retiene ni transfiere dinero. Todos los pagos se hacen directamente al propietario, por lo que es importante verificar bien los datos antes de transferir.",
            ),
            FAQTile(
              question: "¿Cómo activo una suscripción premium?",
              answer:
              "Realiza el pago correspondiente y sube el comprobante. Un administrador validará la información y activará tu suscripción manualmente.",
            ),
            FAQTile(
              question: "¿Qué beneficios tengo como usuario premium?",
              answer:
              "Acceso prioritario a espacios, reservas protegidas que no pueden ser modificadas por el propietario, y funciones adicionales dentro de la plataforma.",
            ),
            FAQTile(
              question: "¿Qué hago si sospecho de un fraude?",
              answer:
              "Puedes reportar el local desde la sección de detalles. El equipo revisará el caso y tomará medidas si corresponde. Reportes falsos pueden llevar a sanciones.",
            ),
            FAQTile(
              question: "¿Puedo posponer una reserva?",
              answer:
              "Sí, pero solo si la reserva no es premium. Las reservas estándar se pueden posponer desde el calendario si están resaltadas en azul en un máximo de una hora.",
            ),
          ],
        ),
      ),
    );
  }
}

class FAQTile extends StatelessWidget {
  final String question;
  final String answer;

  const FAQTile({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.w400),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              answer,
              style: TextStyle(color: MainTheme.contrast(context)),
            ),
          ),
        ],
      ),
    );
  }
}
