<?php
$host = 'data'; // Nom du conteneur MySQL sur le réseau Docker
$user = 'root';
$password = 'rootpass';
$database = 'testdb';

// Connexion au serveur MySQL
$conn = new mysqli($host, $user, $password);

// Vérifier la connexion
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Créer la base de données si elle n'existe pas
$sql = "CREATE DATABASE IF NOT EXISTS $database";
if ($conn->query($sql) === TRUE) {
    echo "Database created successfully or already exists.<br>";
} else {
    echo "Error creating database: " . $conn->error;
}

// Sélectionner la base de données
$conn->select_db($database);

// Créer la table si elle n'existe pas
$sql = "CREATE TABLE IF NOT EXISTS test_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
)";
if ($conn->query($sql) === TRUE) {
    echo "Table created successfully or already exists.<br>";
} else {
    echo "Error creating table: " . $conn->error;
}

// Insérer des données dans la table
$sql = "INSERT INTO test_table (name) VALUES ('test')";
$conn->query($sql);

// Récupérer et afficher les données
$result = $conn->query("SELECT * FROM test_table");

while ($row = $result->fetch_assoc()) {
    echo $row['name'] . "<br>";
}

// Fermer la connexion
$conn->close();
?>
