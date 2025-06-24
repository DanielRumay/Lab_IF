// Configuración dinámica del frontend
// Reemplaza los valores aquí si quieres usar inyección desde un archivo externo o backend
const JENKINS_URL = "http://JENKINS_PUBLIC_IP:8080";
const CHECKOV_URL = "https://s3.amazonaws.com/recetas-checkov/scan_report.json";
const GRAFANA_URL = "http://GRAFANA_PUBLIC_IP:3000";

console.log("Frontend cargado. Jenkins:", JENKINS_URL);
