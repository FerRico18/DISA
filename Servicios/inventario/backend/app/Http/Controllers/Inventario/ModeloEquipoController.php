<?php

namespace App\Http\Controllers\Inventario;

use App\Http\Controllers\Controller;
use App\Models\Inventario\ModeloEquipo;
use Illuminate\Http\Request;

class ModeloEquipoController extends Controller
{
    public function index()
    {
        return ModeloEquipo::with('tipo')->get();
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'id_modelo' => 'required|string|unique:modelo_equipo,id_modelo',
            'nombre_modelo' => 'required|string',
            'descripcion' => 'nullable|string',
            'id_tipo' => 'required|integer',
        ]);

        return ModeloEquipo::create($validated);
    }

    public function show($id)
    {
        return ModeloEquipo::with('tipo')->findOrFail($id);
    }

    public function update(Request $request, $id)
    {
        $modelo = ModeloEquipo::findOrFail($id);
        $modelo->update($request->all());
        return $modelo;
    }

    public function destroy($id)
    {
        ModeloEquipo::destroy($id);
        return response()->json(['message' => 'Modelo eliminado']);
    }
}
