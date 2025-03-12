<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Divisions extends Model
{
    /** @use HasFactory<\Database\Factories\DivisionsFactory> */
    use HasFactory;

    protected $fillable = ['name', 'description'];

    public function members() {
        return $this->hasMany(Members::class);
    }
}
