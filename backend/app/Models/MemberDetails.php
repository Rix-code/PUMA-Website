<?php

namespace App\Models;

use App\Models\Roles;
use App\Models\Members;
use App\Models\Cabinets;
use App\Models\Divisions;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class MemberDetails extends Model
{
    /** @use HasFactory<\Database\Factories\MemberDetailsFactory> */
    use HasFactory;
    protected $fillable = ['member_id', 'cabinet_id', 'division_id', 'role_id'];

    
    public function member() {
        return $this->belongsTo(Members::class);
    }

    public function cabinet() {
        return $this->belongsTo(Cabinets::class);
    }

    public function division() {
        return $this->belongsTo(Divisions::class);
    }

    public function role() {
        return $this->belongsTo(Roles::class);
    }
}
