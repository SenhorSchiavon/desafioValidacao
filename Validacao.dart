import 'dart:io';

//https://rainy-sweater-4ce.notion.site/Desafio-dart-ad1c4165dfd540639d50d4eb5b293c87
void main() {
  var textos =
      "Então resolveu ir brincar com a Máquina pra ser também imperador dos filhos da mandioca. Mas as três cunhas deram muitas risadas e falaram que isso de deuses era gorda mentira antiga, que não tinha deus não e que com a máquina ninguém não brinca porque ela mata. A máquina não era deus não, nem possuía os distintivos femininos de que o herói gostava tanto. Era feita pelos homens. Se mexia com eletricidade com fogo com água com vento com fumo, os homens aproveitando as forças da natureza. Porém jacaré acreditou? nem o herói! Se levantou na cama e com um gesto, esse sim! bem guaçu de desdém, tó! batendo o antebraço esquerdo dentro do outro dobrado, mexeu com energia a munheca direita pras três cunhas e partiu. Nesse instante, falam, ele inventou o gesto famanado de ofensa: a pacova.";
  // var oUsuario = le_assinatura();
  // var textos = le_textos();
//   var textoInfectado = avalia_textos(textos, oUsuario);
//   print(
//       "O texto mais provável de ter sido infectado por COH-PIAH é o texto $textoInfectado");
  print(calcula_assinatura(textos));
}

//Esse é o jeito de fazer input no dart
// List<double> le_assinatura() {
//   print("Bem-vindo ao detector automático de COH-PIAH.");
//   print("Informe a assinatura típica de um aluno infectado:");
//   print("Tamanho médio da palavra:");
//   double wal = double.parse(stdin.readLineSync()!);
//   print("Relação Type-Token:");
//   double ttr = double.parse(stdin.readLineSync()!);
//   print("Razão Hapax Legomana:");
//   double hlr = double.parse(stdin.readLineSync()!);
//   print("tamanho médio de sentença:");
//   double sal = double.parse(stdin.readLineSync()!);
//   print("complexidade média da sentença:");
//   double sac = double.parse(stdin.readLineSync()!);
//   print("tamanho médio de frase:");
//   double pal = double.parse(stdin.readLineSync()!);

//   return [wal, ttr, hlr, sal, sac, pal];
// }

//Input padrão de texto para com a condicional
// List<String> le_textos() {
//   print("Informe os textos a serem comparados (Aperte Enter para encerrar):");
//   var textos = <String>[];
//   while (true) {
//     var texto = stdin.readLineSync()!;
//     if (texto.isEmpty) {
//       break;
//     }
//     textos.add(texto);
//   }
//   return textos;
// }

//Isso é basicamente a transcrição do desafio.
// double compara_assinatura(List<double> as_a, List<double> as_b) {
//   double somaDiferenca = 0;
//   for (var i = 0; i < 6; i++) {
//     somaDiferenca += ((as_a[i] - as_b[i]).abs()) / 6;
//   }
//   return somaDiferenca / as_a.length;
// }

//função própria armazenar as funções criadas
List<double> calcula_assinatura(String texto) {
  var sentencas = separa_sentencas(texto);
  var frases = sentencas.expand(separa_frases).toList();
  var palavras = frases.expand(separa_palavras).toList();
  var wal = tamanhoMedioPalavra(palavras);
  var ttr = relacaoTypeToken(palavras);
  var hlr = razaoHapaxLegomana(palavras);
  var sal = tamanhoMedioSentenca(sentencas);
  var sac = complexidadeMediaSentenca(frases, sentencas);
  var pal = tamanhoMedioFrase(frases);

  return [wal, ttr, hlr, sal, sac, pal];
}

// int avalia_textos(List<String> textos, List<double> oUsuario) {
//   var similaridadeMinima = double.infinity;
//   var textoInfectado = 0;

//   for (var i = 0; i < textos.length; i++) {
//     var assinaturaTexto = calcula_assinatura(textos[i]);
//     var similaridade = compara_assinatura(oUsuario, assinaturaTexto);

//     if (similaridade < similaridadeMinima) {
//       similaridadeMinima = similaridade;
//       textoInfectado = i + 1;
//     }
//   }

//   return textoInfectado;
// }

//Tamanho médio de palavra é a soma dos tamanhos das palavras dividida pelo número total de palavras.
//Essa ideia do reduce foi fazer ele pegar valor por alor do mapa e ir somando.
double tamanhoMedioPalavra(List<String> palavras) {
  var totalCaracteres =
      palavras.map((palavra) => palavra.length).reduce((a, b) => a + b);
  return totalCaracteres / palavras.length;
}

//Relação Type-Token é o número de palavras diferentes dividido pelo número total de palavras.
double relacaoTypeToken(List<String> palavras) {
  var palavrasUnicas = palavras.toSet().length;
  return palavrasUnicas / palavras.length;
}

//Razão Hapax Legomana é o número de palavras que aparecem uma única vez dividido pelo total de palavras.
double razaoHapaxLegomana(List<String> palavras) {
  var palavrasUnicasUmaVez = n_palavras_unicas(palavras);
  return palavrasUnicasUmaVez / palavras.length;
}

//Tamanho médio de sentença é a soma dos números de caracteres em todas as sentenças dividida pelo número de sentenças
double tamanhoMedioSentenca(List<String> sentencas) {
  var totalCaracteresSentencas =
      sentencas.map((sentenca) => sentenca.length).reduce((a, b) => a + b);
  return totalCaracteresSentencas / sentencas.length;
}

//Complexidade de sentença é o número total de frases divido pelo número de sentenças.
double complexidadeMediaSentenca(List<String> frases, List<String> sentencas) {
  return frases.length / sentencas.length;
}

//Tamanho médio de frase é a soma do número de caracteres em cada frase dividida pelo número de frases no texto
double tamanhoMedioFrase(List<String> frases) {
  var totalCaracteresFrases =
      frases.map((frase) => frase.length).reduce((a, b) => a + b);
  return totalCaracteresFrases / frases.length;
}

//Uso de Regex para filtrar
List<String> separa_sentencas(String texto) {
  var separadores = RegExp(r'[.!?]+');
  return texto
      .split(separadores)
      .where((sentenca) => sentenca.isNotEmpty)
      .toList();
}

List<String> separa_frases(String sentenca) {
  var separadores = RegExp(r'[,:;]+');
  return sentenca
      .split(separadores)
      .where((frase) => frase.isNotEmpty)
      .toList();
}

List<String> separa_palavras(String frase) {
  return frase.split(' ').where((palavra) => palavra.isNotEmpty).toList();
}

//A ideia aqui é fazer um tipo de hashmap.
int n_palavras_unicas(List<String> lista_palavras) {
  var contagem = <String, int>{};
  for (var palavra in lista_palavras) {
    contagem[palavra] =
        contagem.containsKey(palavra) ? contagem[palavra]! + 1 : 1;
  }

  return contagem.values.where((count) => count == 1).length;
}
