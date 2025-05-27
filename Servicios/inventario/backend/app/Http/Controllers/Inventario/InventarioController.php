<?php

namespace App\Http\Controllers\Inventario;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Inventario\Inventario;

class InventarioController extends Controller
{
    public function index()
    {
        return Inventario::with(['equipo', 'empleado'])->get();
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'estatus' => 'required|string|max:255',
            'fecha_ingreso' => 'required|date',
            'fecha_modificacion' => 'required|date',
            'id_empleado' => 'required|integer',
            'folio_equipo' => 'required|exists:equipos,folio_equipo',
        ]);

        return Inventario::create($validated);
    }

    public function show($id)
    {
        return Inventario::with(['equipo'])->findOrFail($id);
    }

    public function update(Request $request, $id)
    {
        $inv = Inventario::findOrFail($id);
        $inv->update($request->all());
        return $inv;
    }

    public function destroy($id)
    {
        Inventario::destroy($id);
        return response()->json(['message' => 'Registro eliminado']);
    }
}
