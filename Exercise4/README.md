ASSUMPTIONS
1. Deploy dell'infrastruttura su AWS.
2. Sviluppo dell'infrastruttura con AWS CloudFormation e deploy automatizzato con Terraform.
3. ec2-image-assumption-wordpress = immagine EC2 preparata preventivamente con le seguenti caratteristiche:
	- Lamp server (Amazon Linux2, web server Apache, PHP, MySQL DB).
	- Installazione ultima versione WordPress (wget https://wordpress.org/latest.tar.gz).
	- Installazione MySQL DB.
	- Creazione file di configurazione di WordPress dove definiamo DB e utente DB appena creato allo step sopra.
	- Consentire utilizzo dei permalink da parte di WordPress.
	- Correggere i permessi dei file in modo opportuno.
4. Selezionare la capacità dello spazio di archiviazione (EBS) della tua istanza in modo opportuno.
5. Dominio gestito dal cliente esternamente ad AWS, a tal proposito dovrò fornire al cliente il DNS name del Load Balancer pubblico.
Se AWS Global Accelerator introdotta direttamente nella prima fase del progetto allora fornirò al cliente i 2 IP associati all'AWS G.A. che a sua volta 
dovrà essere configurato con il DNS name ALB pubblico.
6. ALB protocollo HTTPS con certificato distribuito da AWS e gestito direttamente nel servizio apposito (Amazon Certificate Manager)
7. Macchina EC2 bastion host con requisiti minimi da inizializzare a priori con funzionalità da jump gateway per collegarsi alla macchina che ospita il sito
8. Nel security group della macchina di produzione che ospita il sito deve essere un record con protocollo 22 e s.g. del bastion host così da consentirgli
l'accesso.
9.Per il momento si definisce 1 macchina come target del ASG e come risorse min/max. Monitorando la situazione durante un primo periodo se ne capirà
l'esigenza.
10.Si considera Milano (eu-south-1) come region in cui avviene il deploy delle risorse.
11.Ho organizzato le risorse su 2 AZ per garantire l'alta affidabilità (anche se non espressamente richiesto).
12.arn:aws:acm:eu-south-1:assumption -> AC Certificate creato nella region di Milano (eu-south-1).

MIGLIORIE (da implementare direttamente in fase 1 o eventualmente in fase 2 del progetto)
1. Spostare il DB MySQL su Amazon RDS con stesso engine (MySQL) per disaccoppiare il funzionamento del DB dalla macchina che ospita il sito ottenendo cosi 
scalabilità, maggiore sicurezza, scalabilità automatica e rendendo il sistema fault-tolerant (ipotizzato in fase 1).
RDS Multi AZ con primary instance e standby instance.
2. Utilizzare AWS Global Accelerator per ridurre la latenza migliorando le prestazioni del traffico internet tra gli utenti e l'applicazione WordPress 
in esecuzione su AWS.
AWS Global Accelerator utilizza la rete globale AWS per indirizzare il traffico dell'applicazione a un endpoint integro nella regione AWS più vicina al 
client.
3.Possibilità di proporre al cliente soluzione aggiuntiva di disaster recovery.
4.Si può pensare quindi all'utilizzo di AWS Backup per soluzione di business continuity.
5.Ho proposto nell'architettura associata la configurazione di uno storage di rete EFS da utilizzare come file system condiviso in Wordpress.

APPROFONDIMENTO TECNICO/ARCHITETTURA
1.Per soddisfare i requisiti di progetto ho sviluppato il disegno architetturale (ex4-AWSArchitecture.pdf).
2.L'architettura proposta risponde anche alla caratteristica di alta affidabilità.
3.Ho introdotto l'auto scaling group per migliorare la fault tolerance dell'applicazione.
4.Per rispondere al requisito di sicurezza ho associato la macchina che ospita il sito in una subnet definita come private e accessibile da bastion host.
5.Inoltre ho configurato il WAF dove definito un ip set e una Web ACL associando gli indirizzi IP che possono accedere al bastion host.
6.Ho definito tag per ogni risorsa così da sfruttarne le caratteristiche per ricerca e gestione risorse.

DEPLOYMENT PROCESS
1.Importare o replicare la cartella terraform-cloudformation all'interno del proprio ambiente terraform.
2.Eseguire e considerare tutto l'elenco iniziale che riguarda le "ASSUMPTIONS".
3.Eseguire i seguenti comandi su terraform (il file principale è main.tf):
-terraform init
-terraform fmt
-terraform validate
-terraform apply

