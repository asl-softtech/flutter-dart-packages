import 'package:flutter/material.dart';
import 'package:g_sync/g_sync.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GomuGomuSync.init("com.asl.g_sync_example");
  runApp(const GSyncExampleApp());
}

class GSyncExampleApp extends StatelessWidget {
  const GSyncExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'G-Sync Showcase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.dark,
        ),
        fontFamily: 'Outfit',
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GSTable _sampleUploadTable = GSTable(
    id: 1,
    tableName: 'Orders',
    urlToHeat: 'https://api.example.com/upload',
    methode: GSNetworkMethode.post,
    tableType: GSTableTypes.uploadTable,
  );

  // final GSTable _sampleDownloadTable = GSTable(
  //   id: 2,
  //   tableName: 'Products',
  //   urlToHeat: 'https://api.example.com/download',
  //   methode: GSNetworkMethode.get,
  //   tableType: GSTableTypes.downloadTable,
  // );

  // ignore: prefer_final_fields
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.primaryContainer.withAlpha(50),
            ],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              _buildAppBar(),
              SliverToBoxAdapter(child: _buildHeader()),
              SliverToBoxAdapter(child: _buildActionButtons()),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                  child: Text(
                    "SYNC TABLES",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              _buildTableLists(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      floating: true,
      backgroundColor: Colors.transparent,
      title: const Text(
        "G-Sync Showcase",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
      ),
      actions: [
        IconButton(
          onPressed: () => setState(() {}),
          icon: const Icon(Icons.refresh),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withAlpha(80),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.sync_problem, color: Colors.white, size: 32),
                SizedBox(width: 12),
                Text(
                  "Sync Engine Ready",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Manage your offline data and network synchronization seamlessly with G-Sync.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const LinearProgressIndicator(color: Colors.white)
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _buildActionCard(
              "Add Order",
              Icons.add_shopping_cart,
              () async {
                await GomuGomuSync.saveToTable(
                  table: _sampleUploadTable,
                  data: {
                    'item': 'Smartphone X',
                    'price': 999.0,
                    'timestamp': DateTime.now().toIso8601String(),
                  },
                );
                setState(() {});
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildActionCard("Clear Data", Icons.delete_sweep, () async {
              await GomuGomuSync.clearAllTables();
              setState(() {});
            }, isSecondary: true),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    String title,
    IconData icon,
    VoidCallback onTap, {
    bool isSecondary = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: isSecondary
              ? Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest.withAlpha(100)
              : Theme.of(context).colorScheme.primaryContainer.withAlpha(100),
          border: Border.all(color: Colors.white.withAlpha(20)),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSecondary
                  ? Colors.white70
                  : Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildTableLists() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          _buildTableCard(
            "Download Tables (Products)",
            Icons.download_rounded,
            GomuGomuSync.getDownloadTables(),
          ),
          const SizedBox(height: 16),
          _buildTableCard(
            "Upload Tables (Orders)",
            Icons.upload_rounded,
            GomuGomuSync.getUploadTables(),
          ),
          const SizedBox(height: 80),
        ]),
      ),
    );
  }

  Widget _buildTableCard(
    String title,
    IconData icon,
    Future<List<GSData>> dataFuture,
  ) {
    return FutureBuilder<List<GSData>>(
      future: dataFuture,
      builder: (context, snapshot) {
        final data = snapshot.data ?? [];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Theme.of(
              context,
            ).colorScheme.surfaceContainerLow.withAlpha(150),
            border: Border.all(color: Colors.white.withAlpha(10)),
          ),
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  "${data.length} Tables",
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              if (data.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    "No records found",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              else
                ...data.map((table) {
                  // This is a simplification, table types vary
                  return ListTile(
                    title: Text(table.tableName),
                    subtitle: Text("ID: ${table.tableID}"),
                    trailing: const Icon(Icons.chevron_right, size: 16),
                  );
                }),
            ],
          ),
        );
      },
    );
  }
}
