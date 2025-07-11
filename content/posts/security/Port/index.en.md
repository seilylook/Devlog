+++
date = '2025-07-04T10:54:19+09:00'
draft = false
featuredImage = "/images/features/security.jpeg"
categories = ["Cyber Security"]
tags = ["Port"]
title = 'Port'
+++

# 🔍 포트 정보 수집이 왜 중요할까?

Kali Linux를 활용한 모의 해킹(Penetration Testing)이나 침투 테스트에서 가장 기본이자 중요한 단계 중 하나는 **포트 스캐닝(port scanning)**입니다.  
그런데 그 전에 먼저, **"포트(port)"가 무엇인지** 정확히 알고 넘어가는 게 중요하겠죠?

---

## 🚪 포트(Port)란 무엇인가?

### 📫 IP 주소는 집 주소, 포트는 문(door)

컴퓨터 간 통신은 **IP 주소와 포트 번호**를 통해 이루어집니다.

- **IP 주소**: 한 대의 컴퓨터(혹은 장비)를 식별하는 주소 (예: 192.168.0.10)
- **포트 번호**: 그 컴퓨터 안에서 실행 중인 **특정 서비스(프로그램)**를 식별하는 번호

> 예를 들어, 당신이 한 집에 여러 개의 방(서비스)이 있다고 생각해보세요.  
> 택배는 집 주소(IP)만으로는 정확히 어디에 둘지 알 수 없죠.  
> **포트 번호는 각 방에 해당하는 문 번호**입니다.

### 📦 실제 예시

| 포트 번호 | 서비스 | 설명 |
|-----------|--------|------|
| 21        | FTP    | 파일 전송 프로토콜 |
| 22        | SSH    | 원격 접속 (터미널) |
| 80        | HTTP   | 일반 웹 서비스 |
| 443       | HTTPS  | 보안 웹 서비스 (SSL/TLS) |
| 3306      | MySQL  | 데이터베이스 접속용 포트 |

운영 체제는 포트 번호(0~65535)를 기준으로 수많은 서비스를 구분하고 관리합니다.

---

## 📌 포트 정보 수집이 중요한 이유

포트는 단순한 숫자가 아닙니다.  
**포트가 열려 있다는 건, 그 시스템이 외부와 통신할 수 있는 문이 열려 있다는 뜻**입니다.

### 1. 서비스 식별 (Service Fingerprinting)

열린 포트를 통해 **어떤 서비스가 실행 중인지** 파악할 수 있습니다.

예: 22번 포트가 열려 있다면 SSH 접속이 가능할 수 있습니다.

`nmap` 같은 도구는 버전까지 식별해줍니다 → 이를 통해 **취약한 버전인지** 확인 가능

---

### 2. 취약점 분석 및 공격 경로 탐색

오래된 소프트웨어나 설정이 잘못된 서비스가 열린 포트를 통해 외부에 노출되면?
  → 공격자가 그 포트를 통해 시스템을 침투할 수 있습니다.


Apache 2.2가 80번 포트에서 동작 중 → 이미 공개된 취약점이 있을 수 있음

MySQL이 외부 포트로 열려 있음 → 무차별 대입 공격 시도 가능

---

### 3. 방화벽 우회 및 내부 진입

일부 포트는 **방화벽에 의해 허용**되어 있는 경우가 있습니다.

이 포트를 활용해 내부 네트워크로 들어가거나, 다른 시스템으로 이동하는 **수평 이동 lateral movement**이 가능합니다.

---

### 4. 공격 벡터(공격 경로) 분석

포트가 열려 있고, 해당 서비스가 **취약**하거나 **잘못 구성**되어 있으면?
  → 공격자는 그것을 **공격 벡터**로 삼을 수 있습니다.

FTP(21번) 서비스가 익명 로그인 허용 → 파일 업로드/다운로드 가능
SMB(445번) 서비스가 열려 있음 → `EternalBlue` 같은 악명 높은 공격 가능

---

### 5. 정보 수집은 침투 테스트의 시작

> 포트 스캔은 건물의 모든 문을 두드려보고, 어디가 열려 있는지를 확인하는 작업입니다.

열린 포트를 통해:
- 실행 중인 서비스 정보
- 운영 체제 추정
- 방화벽 설정 여부
- 기타 인프라 구조

등 다양한 정보를 간접적으로 수집할 수 있습니다.

---

## 🛠 Kali Linux에서 사용하는 대표적인 도구들

| 도구 | 설명 |
|------|------|
| `nmap` | 대표적인 포트 스캐너 (서비스 식별 가능) |
| `masscan` | 초고속 포트 스캐너 |
| `netcat (nc)` | 포트 연결 및 테스트 도구 |
| `enum4linux`, `nikto`, `gobuster` | 열린 포트 기반 서비스에 대한 정보 수집 |

---

## 🧪 예시 흐름 (nmap 활용)

```bash
# 1. 전체 포트 스캔
nmap -sS -p- <타겟 IP>

# 2. 열린 포트의 서비스 및 버전 식별
nmap -sV -p <열린 포트 목록> <타겟 IP>

# 3. 탐색된 서비스 버전에 맞는 취약점 검색
searchsploit <서비스명>
