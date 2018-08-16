# sonar-swift-sample

### Objetivo

Automatizar testes e levantar estatísticas de um projeto desenvolvido em Swift. 
Ficando assim Jenkins como responsável por verificar novos commits nas branchs escolhidas e após rotina de build, testes e relatórios, reportar para o sonarqube.

### Quais ferramentas foram utilizadas?

A solução contempla a utilização das seguintes ferramentas, jenkins e sonarqube.

### Iniciando a integração da solução

1. Instalações
* xcode-select --install
* \curl -sSL https://get.rvm.io | bash -s stable --ruby
* rvm install ruby
* gem install xcpretty
* gem install lizard
* gem install slather
* gem install sonar
* /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
* brew install swiftlint
> Caso você decida instalar o docker como eu, acesse o portal do docker e vá ná área de downloads.

2. Para baixar e configurar o sonarqube no docker é necessário inserir o comando:

* docker pull sonarqube:6.7.4 
* docker run -d --name sonarqube -p 9000:9000 -p 9092:9092 sonarqube:6.7.4
> (:6.7.4 é a versão desejada atualmente|10/08/2018, também poderia ser utilizado apenas o sonarqube sem especificação de versão, pegando assim a mais atual).

3. Já para o Jenkins é necessário instalar o java (JDK) mais atual, baixar o executável do Jenkins LTS no site do mesmo e após instalação abrir terminal e executar:

* export JAVA_HOME=\`/usr/libexec/java_home -v 1.8\`
* java -jar /Applications/Jenkins/jenkins.war
> Você tambêm poderia adicionar <b>export JAVA_HOME=``/usr/libexec/java_home -v 1.8``</b> ao ~/.bash-profile
> Na primeira vez q é iniciado um novo jenkins, é necessário pegar a chave gerada neste caminho: <b>/var/jenkins_home/secrets/initialAdminPassword</b> e utilizar este password ao acessar pela primeira vez o <b>localhost:8080</b>
> Finalizando isso, ambientes estarão parcialmente prontos podendo assim serem acessados por <b>localhost:8080</b> (jenkins) e <b>localhost:9000</b> (sonarqube)

4. Para prosseguimento de um projeto em swift é necessário que seja instalado o plugin backelite-sonar-swift-plugin no sonarqube, este pode ser encontrado no github <b>backelite/sonar-swift</b>

> Após este ser baixado é necessário que seja acessado pelo terminal o diretório onde esteja localizado o plugin, lembrando que esse caminho é um exemplo utilizando a versão 0.3.7 do plugin

* docker cp backelite-sonar-swift-plugin-0.3.7.jar sonarqube:opt/sonarqube/extensions/plugins
* docker restart sonarqube
  * Logo após a instalação do plugin restart o sonarqube e após isto selecione:
  ![alt text](https://i.imgur.com/r12j0my.png)
  * Busque este `Quality Profile` para validar se foi instalado corretamente no sonarqube
  ![alt text](https://i.imgur.com/ymh28UF.png)

5. Para prosseguir é necessário que você inicie o projeto iOS, vá em `edit scheme`, na opção `Test` entre em `Options`, selecione `Gather coverage for` e marque `all targets`.

> Ah, e também deixe o Scheme como <b>Shared</b>

Será necessário o arquivo <b>sonar-project.properties</b> configurado para o seu projeto, este arquivo como exemplo pode ser encontrado na raiz deste projeto.

É necessário que também seja adicionado na raiz do projeto o script que o próprio plugin fornece, chamado run-sonar.sh, também está neste projeto.

Bom, depois de tudo isso, abra o terminal, vá para o diretorio raiz do seu projeto onde estão localizados run-sonar.sh e sonar-project.properties

* ./run-sonar.sh

> Ve no que dá, se tudo foi configurado direitinho, e não tivemos nenhuma grande atualização no ambiente do xcode, deve dar tudo certo.
> Foi? Sem erro?
> Confere no sonarqube, lembrando que é <b>localhost:9000</b>
> `admin:admin` normalmente é o acesso padrão inicial

![alt text](https://i.imgur.com/dyrFAZh.png)

> Apareceu o projeto lá como na imagem acima? Show, agora podemos ir para o Jenkins.

Acesse o jenkins, <b>localhost:8080</b>

Acesse a opção de `new freestyle project`, de um nome para o projeto e prossiga.

Nesta primeira etapa você pode deixar algumas informações especificando um pouco sobre o projeto

![alt text](https://i.imgur.com/3ZkqenK.png)

Já nesta você precisa configurar o ambiente git (repositório e branch desejada), caso o repositório seja privado será necessário adicionar suas credenciais de git no Jenkins e dps selecioná-las posteriormente nesta opção.

> Lembrando que você pode adicionar inúmeros repositórios para serem checados com essa mesma rotina

![alt text](https://i.imgur.com/qHrGNh1.png)

Aqui eu adiciono um tempo médio de checagem do repositório, desta maneira ai ajustada ele fica checando de 5 em 5 minutos por commits e também decidi que gostaria de limpar todo o workspace a cada novo update de codigo.

![alt text](https://i.imgur.com/Ocsb8yt.png)

Esta opção é onde você adiciona o codigo shell necessário, caso seja do seu interesse, dessa forma acabei optando por copiar o diretório onde o Jenkins baixa a aplicação, dentro do seu ambiente, e colei em um diretório fora do ambiente do Jenkins e posteriormente acesso a pasta e mando rodar o script shell que indiquei logo no inicio deste tutorial.

![alt text](https://i.imgur.com/0na3ecC.png)

## PRONTO

Feito isso, a cada novo commit na branch configurada no Jenkins, o mesmo detecta e manda rodar sua rotina de build, no meu caso foram aqueles comandos shell, assim que chega no ./run-sonar.sh ele inicia o processo de build do projeto, teste e a geração de relatórios, tudo dando certo ele já envia todos esses para o sonarqube e vualá.

![alt text](https://i.imgur.com/WYxQ1yK.png)
![alt text](https://i.imgur.com/L8piKRu.png)
