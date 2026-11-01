# Mobile-Dart-Flutter
Mobile App development for AMAZUL challenge




                                  ████╗  ██║██║   ██║██╔════╝██║     ██╔════╝██╔══██╗██╔══██╗
                                  ██╔██╗ ██║██║   ██║██║     ██║     █████╗  ███████║██████╔╝
                                  ██║╚██╗██║██║   ██║██║     ██║     ██╔══╝  ██╔══██║██╔══██╗
                                  ██║ ╚████║╚██████╔╝╚██████╗███████╗███████╗██║  ██║██║  ██║
                                  ╚═╝  ╚═══╝ ╚═════╝  ╚═════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝

                                                   ██████╗  ██████╗  ██████╗ 
                                                   ╚════██╗██╔════╝ ██╔═████╗
                                                    █████╔╝███████╗ ██║██╔██║
                                                    ╚═══██╗██╔═══██╗████╔╝██║
                                                   ██████╔╝╚██████╔╝╚██████╔╝
                                                   ╚═════╝  ╚═════╝  ╚═════╝ 


                                            — reacenda a cidade com a verdade —



Plataforma gamificada que aproxima a sociedade da **tecnologia nuclear**, mostrando suas aplicações e benefícios na saúde, agricultura, indústria, pesquisa e energia — de forma simples, interativa e sempre acompanhada da fonte.

**Challenge FIAP · Parceiro: AMAZUL — Amazônia Azul Tecnologias de Defesa (Marinha do Brasil)**

---

## 👥 Integrantes

| Nome | RM |
| --- | --- |
| Pedro Falchi | RM566967 |
| Matheus Guimarães | RM567912 |
| Lucas Shida | RM568194 |

**Turma:** 2TDSPS

---

## 📖 Descrição da solução

O **Nuclear 360** é um aplicativo que combate a desinformação sobre energia nuclear por meio de uma experiência narrativa e gamificada. Ambientado em um Brasil de 2070 onde a tecnologia nuclear foi banida, o usuário assume o papel de um agente da resistência científica e **reacende a cidade distrito por distrito**, derrubando mitos com fatos.

Cada distrito representa uma área de aplicação (Saúde, Agricultura, Indústria, Pesquisa e Energia) e reúne missões como quizzes e o modo **Verdade ou Radioativo**. Após cada resposta, o usuário recebe uma **explicação objetiva e a referência utilizada**, atendendo ao objetivo central do desafio.

Esta é a primeira versão funcional, desenvolvida em **Dart**, contemplando navegação entre telas, gerenciamento de estado, formulários com validação e protótipo visual.

### Principais funcionalidades

- **Navegação** completa entre telas, com passagem de parâmetros (Mapa → Distrito)
- **Cadastro e Login** com validação de campos e feedback ao usuário
- **Quiz** com placar em tempo real, integrado à **API Java** do projeto (com dados mockados como fallback)
- **Verdade ou Radioativo** — classificação de mitos e fatos
- **Medidor de Bananas** — converte doses de radiação em uma unidade do dia a dia
- **Perfil** do agente com XP, patente e insígnias

---

## 🚀 Instruções de execução

**Pré-requisito:** [Dart SDK 3.3+](https://dart.dev/get-dart).

```bash
# 1. instalar as dependências
dart pub get

# 2. executar o aplicativo (com a introdução narrativa)
dart run bin/main.dart

# ou, para ir direto ao menu principal:
dart run bin/main.dart --sem-intro
```

> Use um terminal com suporte a cores e UTF-8 (Windows Terminal, terminal do VS Code, macOS ou Linux).

### Integração com a API (opcional)

O Quiz consome a API Java do projeto. Com a API rodando em `http://localhost:8080`, as perguntas vêm do backend automaticamente; se a API estiver indisponível, o app usa dados mockados sem interromper a experiência.

```bash
# apontar para a API em outro endereço, se necessário:
dart run --define=API_URL=http://SEU-IP:8080 bin/main.dart
```

---

## 🛠️ Tecnologias utilizadas

- **Dart 3** — linguagem principal
- **dart:io / dart:convert** — cliente HTTP e navegação em terminal (sem dependências externas)
- **Arquitetura em camadas** — `models`, `data` (mock + API), `services`, `validators`, `state`, `screens`, `widgets`
- **Integração REST** com a API **Java (Spring Boot)** do Nuclear 360

---

## 🎥 Vídeo demonstrativo

YouTube (não listado): https://youtu.be/PbcK9irvbVY