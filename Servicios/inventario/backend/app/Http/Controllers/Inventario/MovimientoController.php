<?php

namespace App\Http\Controllers\Inventario;

use App\Http\Controllers\Controller;
use App\Models\Inventario\Movimiento;
use Illuminate\Http\Request;

class MovimientoController extends Controller
{
    public function index()
    {
        return Movimiento::with(['equipo', 'unidad'])->get();
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'fecha_inicio' => 'required|date',
            'fecha_fin' => 'nullable|date',
            'tipo' => 'required|string',
            'descripcion' => 'nullable|string',
            'folio_equipo' => 'required|string|exists:equipo,folio_equipo',
            'id_empleado' => 'required|integer',
            'id_unidad_destino' => 'required|integer',
        ]);

        return Movimiento::create($validated);
    }

    public function show($id)
    {
        return Movimiento::with(['equipo', 'unidad'])->findOrFail($id);
    }

    public function update(Request $request, $id)
    {
        $mov = Movimiento::findOrFail($id);
        $mov->update($request->all());
        return $mov;
    }

    public function destroy($id)
    {
        Movimiento::destroy($id);
        return response()->json(['message' => 'Movimiento eliminado']);
    }
}
