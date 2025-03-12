<?php

namespace App\Http\Controllers;

use App\Models\Divisions;
use App\Http\Requests\StoreDivisionsRequest;
use App\Http\Requests\UpdateDivisionsRequest;

class DivisionsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Divisions::all();
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreDivisionsRequest $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(Divisions $divisions)
    {
        return $divisions;
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Divisions $divisions)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateDivisionsRequest $request, Divisions $divisions)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Divisions $divisions)
    {
        //
    }
}
