<?php

namespace App\Http\Controllers\Inventario;

use App\Http\Controllers\Controller;
use App\Models\Inventario\Equipo;
use Illuminate\Http\Request;

class EquipoController extends Controller
{
    public function index()
    {
        return Equipo::with(['modelo', 'tipo'])->get();
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'folio_equipo' => 'required|string|max:100|unique:equipo,folio_equipo',
            'numero_serie' => 'required|string|max:100',
            'procesador' => 'required|string',
            'ram' => 'required|string',
            'tarjeta_red' => 'required|string',
            'MAC_ETH' => 'nullable|string',
            'MAC' => 'nullable|string',
            'so_instalado' => 'nullable|string',
            'uso_actual' => 'nullable|string',
            'descripcion' => 'nullable|string',
            'id_modelo' => 'required|string',
            'id_tipo' => 'required|integer',
        ]);

        return Equipo::create($validated);
    }

    public function show($folio_equipo)
    {
        return Equipo::with(['modelo', 'tipo'])->findOrFail($folio_equipo);
    }

    public function update(Request $request, $folio_equipo)
    {
        $equipo = Equipo::findOrFail($folio_equipo);
        $equipo->update($request->all());
        return $equipo;
    }

    public function destroy($folio_equipo)
    {
        Equipo::destroy($folio_equipo);
        return response()->json(['message' => 'Equipo eliminado']);
    }
}
