CREATE DATABASE examen_MATTEODISEURS;


CREATE TABLE Task (
    task_id int,
    parent_id int NOT NULL,
    description varchar NOT NULL,
    CONSTRAINT pk_Task_task_id PRIMARY KEY (task_id, parent_id)
);


CREATE TABLE Task_Colab(
    colab_id int,
    task_id int NOT NULL,
    CONSTRAINT pk_table_3_id PRIMARY KEY (colab_id, task_id)
);

CREATE TABLE Task_Client (
    task_id int NOT NULL,
    client_id int NOT NULL,
    CONSTRAINT pk_table_4_id PRIMARY KEY (task_id, client_id)
);

CREATE TABLE Collaborateur (
    colab_id int,
    nom varchar,
    prenom varchar,
    pseudo varchar,
    CONSTRAINT "pk_table_2_id" PRIMARY KEY (colab_id)
);

CREATE TABLE Client (
    client_id int NOT NULL,
    nom varchar,
    prenom varchar,
    CONSTRAINT pk_table_5_id PRIMARY KEY (client_id)
);

-- Foreign key constraints
-- Schema: public
ALTER TABLE Task_Colab ADD CONSTRAINT fk_Task_Colab_colab_id_Collaborateur_colab_id FOREIGN KEY(colab_id) REFERENCES Collaborateur(colab_id);
ALTER TABLE Task_Client ADD CONSTRAINT fk_Task_Client_client_id_Client_client_id FOREIGN KEY(client_id) REFERENCES Client(client_id);

ALTER TABLE task ADD CONSTRAINT uc_task_key UNIQUE (task_id);
ALTER TABLE Task_Client ADD CONSTRAINT fk_Task_Client_task_id_Task_task_id FOREIGN KEY(task_id) REFERENCES Task(task_id);

ALTER TABLE task ADD CONSTRAINT uc_task_key UNIQUE (task_id);
ALTER TABLE Task_Colab ADD CONSTRAINT fk_Task_Colab_task_id_Task_task_id FOREIGN KEY(task_id) REFERENCES Task(task_id);