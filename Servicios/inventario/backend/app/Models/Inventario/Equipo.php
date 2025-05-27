<?php

namespace App\Models\Inventario;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Equipo extends Model
{
    use HasFactory;

    protected $table = 'equipo';
    protected $primaryKey = 'folio_equipo';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'folio_equipo',
        'numero_serie',
        'procesador',
        'ram',
        'tarjeta_red',
        'MAC_ETH',
        'MAC',
        'so_instalado',
        'uso_actual',
        'descripcion',
        'id_modelo',
        'id_tipo'
    ];

    public function modelo()
    {
        return $this->belongsTo(ModeloEquipo::class, 'id_modelo');
    }

    public function tipo()
    {
        return $this->belongsTo(TipoEquipo::class, 'id_tipo');
    }
}
