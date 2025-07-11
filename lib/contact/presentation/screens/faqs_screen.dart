import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../public/presentation/widgets/screen_bottom_app_bar.dart';
import '../../../public/ui/providers/theme_provider.dart';
import '../../../public/ui/theme/main_theme.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({super.key});

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  Future<void> _sendEmail() async {
    final String email = _emailController.text.trim();
    final String message = _messageController.text.trim();

    const serviceId = 'service_1hlwtus';
    const templateId = 'template_33xewk8';
    const userId = 'xauMJMGDVAWgwz8SL';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'email': email,
          'message': message,
        },
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mensaje enviado correctamente')),
      );
      _emailController.clear();
      _messageController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al enviar el mensaje')),
      );
    }
  }

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
          children: [
            const FAQTile(
              question: "¿Cómo reservo un espacio?",
              answer:
              "Primero debes iniciar sesión, seleccionar el espacio deseado y completar la información de reserva (fecha y horario). Luego deberás realizar el depósito al número de cuenta indicado y subir el comprobante de pago para su validación.",
            ),
            const FAQTile(
              question: "¿Qué sucede después de subir el comprobante de pago?",
              answer:
              "El propietario del espacio validará el comprobante. Si todo es correcto, la reserva quedará confirmada. En caso de problemas o fraude, el propietario puede rechazarla.",
            ),
            const FAQTile(
              question: "¿AlquilaFácil gestiona el dinero o reembolsa pagos?",
              answer:
              "No. AlquilaFácil no retiene ni transfiere dinero. Todos los pagos se hacen directamente al propietario, por lo que es importante verificar bien los datos antes de transferir.",
            ),
            const FAQTile(
              question: "¿Cómo activo una suscripción premium?",
              answer:
              "Realiza el pago correspondiente y sube el comprobante. Un administrador validará la información y activará tu suscripción manualmente.",
            ),
            const FAQTile(
              question: "¿Qué beneficios tengo como usuario premium?",
              answer:
              "Acceso prioritario a espacios, reservas protegidas que no pueden ser modificadas por el propietario, y funciones adicionales dentro de la plataforma.",
            ),
            const FAQTile(
              question: "¿Qué hago si sospecho de un fraude?",
              answer:
              "Puedes reportar el local desde la sección de detalles. El equipo revisará el caso y tomará medidas si corresponde. Reportes falsos pueden llevar a sanciones.",
            ),
            const FAQTile(
              question: "¿Puedo posponer una reserva?",
              answer:
              "Sí, pero solo si la reserva no es premium. Las reservas estándar se pueden posponer desde el calendario si están resaltadas en azul en un máximo de una hora.",
            ),
            const SizedBox(height: 24),
            Divider(color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              '¿Aún tienes dudas?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: MainTheme.contrast(context),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Tu correo electrónico',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _messageController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Tu mensaje',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _sendEmail,
              icon: const Icon(Icons.send),
              label: const Text('Enviar mensaje al soporte'),
              style: ElevatedButton.styleFrom(
                backgroundColor: MainTheme.primary(context),
                foregroundColor: Colors.white,
              ),
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
