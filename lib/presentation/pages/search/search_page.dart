import 'package:bus_booking/presentation/widgets/momo_webview/momo_webview.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _openMomoPayment(context),
          child: const Text('Thanh toán MoMo', style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }

  void _openMomoPayment(BuildContext context) {
    // TODO: Thay bằng URL thật từ backend
    const paymentUrl = 'https://test-payment.momo.vn/v2/gateway/pay';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MomoWebView(
          paymentUrl: paymentUrl,
          onPaymentSuccess: (url) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Thanh toán thành công!'),
                backgroundColor: Colors.green,
              ),
            );
          },
          onPaymentFailed: (url) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Thanh toán thất bại!'),
                backgroundColor: Colors.red,
              ),
            );
          },
        ),
      ),
    );
  }
}
