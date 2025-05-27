<?php

namespace App\Models\Inventario;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Movimiento extends Model
{
    use HasFactory;

    protected $table = 'movimiento';
    protected $primaryKey = 'id_movimiento'; // ajusta si usas otro
    public $incrementing = true;

    protected $fillable = [
        'fecha_inicio',
        'fecha_fin',
        'tipo',
        'descripcion',
        'folio_equipo',
        'id_empleado',
        'id_unidad_destino',
    ];

    public function equipo()
    {
        return $this->belongsTo(Equipo::class, 'folio_equipo');
    }

    public function unidad()
    {
        return $this->belongsTo(UnidadAdmin::class, 'id_unidad_destino');
    }
}
