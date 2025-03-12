<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Members extends Model
{
    /** @use HasFactory<\Database\Factories\MembersFactory> */
    use HasFactory;

    protected $fillable = ['name', 'position', 'batch', 'email', 'phone', 'password', 'role', 'division_id', 'status', 'joined_at', 'left_at', 'profile_image', 'cabinet_id'];

    public function details()
    {
        return $this->hasOne(MemberDetails::class);
    }
}
