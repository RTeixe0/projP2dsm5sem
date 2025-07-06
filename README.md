# 📱 Pokedex Fatec DSM

Projeto Flutter para disciplina de Programação para dispositivos moveis — **FATEC Itapira**  
> Um app de Pokédex que funciona **offline** com SQLite e sincroniza com banco **MySQL na nuvem**

---

## 💡 Funcionalidades

✅ Login com email e senha  
✅ Listagem dos 151 Pokémons da 1ª geração  
✅ Imagens salvas localmente (funciona sem internet)  
✅ Banco de dados local (SQLite)  
✅ Banco de dados remoto (MySQL via API em VM)  
✅ Sincronização automática de dados  
✅ Interface em modo escuro (Dark Mode)

---

## 🛠️ Tecnologias Utilizadas

### 💻 Backend (API)
- Node.js + Express
- MySQL
- Hospedado em VM Linux (Google Cloud)

### 📱 Mobile (Flutter)
- Flutter 3.8+
- sqflite
- path_provider
- http

---

## 🔐 Login de Teste

```
Email: fatec@pokemon.com  
Senha: pikachu
```

---

## 🌐 Como Funciona

| Componente | Papel |
|------------|-------|
| **Flutter** | App mobile com SQLite e interface |
| **SQLite** | Armazena os dados localmente para uso offline |
| **API (VM)** | Expõe rotas para consultar e sincronizar Pokémons |
| **MySQL (VM)** | Armazena os dados de forma centralizada |

---

## 🧪 Testes

- ✅ Testado em emulador Android
- ✅ Testado em celular real (APK)
- ✅ Funciona offline e online
- ✅ Imagens e dados carregam normalmente
- ✅ Login funcional

---

## 🧠 Desenvolvedor

- Renan Teixeira  

---
