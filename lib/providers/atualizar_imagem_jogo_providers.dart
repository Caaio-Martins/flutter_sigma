import 'package:flutter/material.dart';
import 'package:flutter_sigma/models/jogo_model.dart';
import 'package:flutter_sigma/repositories/atualizar_imagem_jogo_repositories.dart';
import 'package:logger/logger.dart';

class JogoProvider with ChangeNotifier {
  final JogoRepository jogoRepository;
  final Logger logger = Logger(); // Instância do Logger
  final List<Jogo> _jogos = []; // Supondo que você tenha uma lista de jogos

  JogoProvider(this.jogoRepository);

  // Método para atualizar a imagem do jogo
  Future<void> updateImagemJogo(int idJogo, String novaReferenciaImagem) async {
    try {
      Jogo updatedJogo = await jogoRepository.updateImagemJogo(idJogo, novaReferenciaImagem);
      logger.i("Imagem do jogo atualizada com sucesso: $idJogo");

      // Atualizar a lista de jogos, se necessário
      final index = _jogos.indexWhere((jogo) => jogo.idJogo == idJogo);
      if (index != -1) {
        _jogos[index] = updatedJogo; // Atualiza o jogo na lista
        notifyListeners(); // Notifica os ouvintes para atualizar a interface
      }
    } catch (e) {
      logger.e("Erro ao atualizar a imagem do jogo: $e");
    }
  }
}
