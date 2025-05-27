<?php

namespace App\Models\Inventario;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Inventario extends Model
{
    use HasFactory;

    protected $table = 'inventario'; // nombre real de la tabla
    protected $primaryKey = 'id_inventario'; 
    public $incrementing = true; 

    protected $fillable = [
        'estatus',
        'fecha_ingreso',
        'fecha_modificacion',
        'id_empleado',
        'folio_equipo',
        // etc.
    ];

     public function equipo()
    {
        return $this->belongsTo(Equipo::class, 'folio_equipo');
    }

    public function empleado()
    {
        return $this->belongsTo(Empleado::class, 'id_empleado');
    }
}
