<?php
$servername = "Hostname";
$database = "hoteles_reservas";
$username = "root";
$password = "";

$conexion = mysqli_connect($servername, $username, $password, $database);

if (!$conexion) {
    die("Connection failed: " . mysqli_connect_error());
}

class Hoteles {
    private $conexion;

    public function __construct($conexion) {
        $this->conexion = $conexion;
    }

    public function destinos() {
        mysqli_set_charset($this->conexion, "utf8");

        $query = "SELECT nombre FROM sedes_hotel";

        $result = mysqli_query($this->conexion, $query);

        if ($result) {
            $data = array();

            while ($row = mysqli_fetch_assoc($result)) {
                $data[] = $row;
            }

            mysqli_free_result($result);
            mysqli_close($this->conexion);

            return json_encode($data, JSON_UNESCAPED_UNICODE);
        } else {
            return json_encode(["error" => "Error en la consulta: " . mysqli_error($this->conexion)]);
        }
    }

    public function tipos($destino) {
        mysqli_set_charset($this->conexion, "utf8");

        // Escapar la variable $destino para evitar inyección SQL
        $destino = mysqli_real_escape_string($this->conexion, $destino);

        $query = "SELECT 
                    tipo.id_tipo,
                    tipo.tipo,
                    habitaciones.id_habitaciones,
                    habitaciones.catidad,
                    sedes_hotel.id_sede_hotel,
                    sedes_hotel.nombre
                FROM tipo
                JOIN habitaciones ON tipo.id_tipo = habitaciones.tipo_id_tipo 
                JOIN sedes_hotel_habitacion ON habitaciones.id_habitaciones = sedes_hotel_habitacion.id_habitaciones
                JOIN sedes_hotel ON sedes_hotel_habitacion.id_sede_hotel = sedes_hotel.id_sede_hotel
                WHERE sedes_hotel.nombre='$destino'";

        $result = mysqli_query($this->conexion, $query);

        if ($result) {
            $data = array();

            while ($row = mysqli_fetch_assoc($result)) {
                $data[] = $row;
            }

            mysqli_free_result($result);
            mysqli_close($this->conexion);

            return json_encode($data, JSON_UNESCAPED_UNICODE);
        } else {
            return json_encode(["error" => "Error en la consulta: " . mysqli_error($this->conexion)]);
        }
    }
}

$Hoteles = new Hoteles($conexion);
switch ($_GET['Metodo']) {
    case 'destinos':
        try {
            $resultados = $Hoteles->destinos();
            echo $resultados;
        } catch (Exception $e) {
            echo "Error: " . $e->getMessage();
        }
        break;

    case 'tipos':
        try {
            // Verificar si se proporciona el parámetro 'IdDestino'
            if (isset($_GET['IdDestino'])) {
                $resultados = $Hoteles->tipos($_GET['IdDestino']);
                echo $resultados;
            } else {
                echo json_encode(["error" => "IdDestino no especificado"]);
            }
        } catch (Exception $e) {
            echo "Error: " . $e->getMessage();
        }
        break;

    default:
        echo json_encode(["error" => "Método no válido"]);
        break;
}
?>
