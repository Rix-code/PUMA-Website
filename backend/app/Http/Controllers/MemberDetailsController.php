<?php

namespace App\Http\Controllers;

use App\Models\MemberDetails;
use App\Http\Requests\StoreMemberDetailsRequest;
use App\Http\Requests\UpdateMemberDetailsRequest;

class MemberDetailsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
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
    public function store(StoreMemberDetailsRequest $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(MemberDetails $memberDetails)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(MemberDetails $memberDetails)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateMemberDetailsRequest $request, MemberDetails $memberDetails)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(MemberDetails $memberDetails)
    {
        //
    }
}
