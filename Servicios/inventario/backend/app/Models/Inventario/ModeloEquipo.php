<?php

namespace App\Models\Inventario;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ModeloEquipo extends Model
{
    use HasFactory;

    protected $table = 'modelo_equipo';
    protected $primaryKey = 'id_modelo'; // string, si es tipo QRXXX123
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'id_modelo',
        'nombre_modelo',
        'descripcion',
        'id_tipo',
    ];

    public function tipo()
    {
        return $this->belongsTo(TipoEquipo::class, 'id_tipo');
    }
}
