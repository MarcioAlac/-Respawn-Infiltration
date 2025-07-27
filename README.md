# Sistema de Helicóptero Dinâmico - Arma 3

Reviva seus soldados e execute infiltrações precisas com este sistema avançado de helicóptero para Arma 3! ✨

## 🎯 Visão Geral

Este sistema oferece uma experiência realista de resgate e infiltração, permitindo que líderes de esquadrão criem pontos de rally dinâmicos e coordenem operações de helicóptero de forma eficiente.

## 🌟 Recursos Principais

### 🎯 RallyPoint Dinâmico
- **SL marca posição** para infiltração
- Permite partidas com menos jogadores mantendo realismo
- Sistema de comunicação por rádio integrado

### ⚡ Resgate Automático
- Helicóptero busca automaticamente soldados mortos na base
- Sistema inteligente de detecção de baixas
- Coordenação automática com IA do piloto

### 🗺️ Infiltração Inteligente
- Pouso preciso em marcadores "zph-infil"
- Sistema de navegação avançado
- Desembarque controlado de tropas

### 🚨 Sistema de Emergência
- Evacuação automática quando RallyPoint é removido
- Seleção manual de ponto de pouso em emergências
- Retorno seguro à base

### 🔄 Retorno Automático
- Helicóptero volta automaticamente à base após missão
- Sistema de pouso seguro na base
- Gerenciamento inteligente de combustível

## 🛠️ Pré-requisitos

- **CBA_A3** - Community Base Addons
- **ACE3** - Advanced Combat Environment

## 🎮 Como Usar

### 1. Criando RallyPoint

1. **Inicie o jogo** e abra o menu self-action do ACE
2. **Procure por "Posicionar Rallypoint"** na interface
3. **Escolha uma das opções:**
   - **Adicionar** - Cria um novo ponto de rally
   - **Remover** - Remove o ponto de rally atual
4. **Confirme a posição** - Um rádio será criado na sua posição atual
5. **Aguarde confirmação** - Você ouvirá ruído de fundo de comunicações indicando que o rally está operacional

### 2. Infiltração Preciso

Para uma **infiltração especial** no ponto exato:

1. **Crie um marcador** com o nome `"zph-infil"`
2. **Posicione o marcador** na localização desejada
3. **O helicóptero pousará** precisamente no local marcado
4. **As tropas serão desembarcadas** automaticamente

### 3. Removendo RallyPoint

Quando terminar o objetivo da missão:

1. **Remova o rallypoint** através do menu ACE
2. **Se houver soldados no helicóptero:**
   - O piloto transmitirá uma mensagem
   - O mapa será aberto automaticamente para o jogador na posição 1
   - **Clique uma vez** para escolher o ponto de pouso desejado
3. **O helicóptero voltará** automaticamente para a base

## 📁 Estrutura do Projeto

```
(DEV)_Missao_Teste_respawnDynamic_aceCompat.VR/
├── description.ext          # Configuração da missão
├── init.sqf                # Script de inicialização
├── mission.sqm             # Arquivo da missão
├── onPlayerRespawn.sqf     # Script de respawn
└── functions/
    ├── fn_menu_player.sqf           # Menu do jogador
    ├── fn_place_rallypoint.sqf      # Sistema de rally point
    └── fn_vehicle_respawn_waypoint.sqf  # Sistema de waypoints do helicóptero
```

## 🔧 Configuração

### Variáveis Globais
- `respawn_helicopter` - Referência ao helicóptero de resgate
- `rallyOn` - Status do sistema de rally
- `originalHeliPos` - Posição original do helicóptero na base

### Marcadores Necessários
- `"helipos"` - Posição da base do helicóptero
- `"zph-infil"` - Marcadores para infiltração precisa

## 🚀 Instalação

1. **Baixe** os arquivos da missão
2. **Coloque** na pasta `mpmissions` do seu servidor
3. **Configure** os pré-requisitos (CBA_A3 e ACE3)
4. **Inicie** a missão no servidor

## 🐛 Solução de Problemas

### Helicóptero não responde
- Verifique se o `respawn_helicopter` está definido
- Confirme se o piloto está vivo
- Verifique se o ACE3 está carregado

### RallyPoint não funciona
- Confirme que o CBA_A3 está instalado
- Verifique se o menu ACE está funcionando
- Teste com um novo rallypoint

### Marcadores não aparecem
- Verifique se o nome do marcador está correto (`"zph-infil"`)
- Confirme se o marcador está visível no mapa
- Teste criando um novo marcador

## 📝 Changelog

### Versão Atual
- Sistema de rally point dinâmico
- Infiltração precisa com marcadores
- Sistema de emergência integrado
- Retorno automático à base

## 👨‍💻 Autor

**⭐ MARCIO ALAC ⭐**

Desenvolvedor e criador do sistema de helicóptero dinâmico para Arma 3.

---

## 📄 Licença

Este projeto é de uso livre para a comunidade Arma 3. Respeite os créditos ao autor.

---

*Para suporte ou dúvidas, entre em contato através dos canais da comunidade.*
