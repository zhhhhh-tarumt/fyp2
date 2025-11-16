import 'dart:ui';

import 'package:flutter/material.dart';

class MerchantScanView extends StatelessWidget {
  const MerchantScanView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Merchant QR Scanner"),
        centerTitle: true,
        elevation: 0,
      ),

      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // -------------------------------------------------------
            // TITLE + SUBTITLE
            // -------------------------------------------------------
            Text(
              "Scan QR to Pay",
              style: TextStyle(
                color: green,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Align the QR code inside the frame",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 30),

            // -------------------------------------------------------
            // QR SCAN GLASS PANEL (Modern Style)
            // -------------------------------------------------------
            Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white.withOpacity(0.15),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Scanner background blur
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        color: Colors.white.withOpacity(0.05),
                      ),
                    ),
                  ),

                  // ❗ SCAN FRAME BORDER
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.green.shade400,
                        width: 3,
                      ),
                    ),
                  ),

                  // ❗ QR Icon Placeholder
                  Icon(
                    Icons.qr_code_scanner_rounded,
                    size: 130,
                    color: Colors.green.shade700.withOpacity(0.7),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            // -------------------------------------------------------
            // EXTRA ACTIONS: Upload from Gallery
            // -------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.photo_library, color: Colors.white),
                  label: const Text(
                    "Upload QR from Gallery",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {},
                ),
              ),
            ),

            const SizedBox(height: 20),

            // -------------------------------------------------------
            // FOOTNOTE
            // -------------------------------------------------------
            Text(
              "Powered by BudgetMate Secure QR Technology",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
