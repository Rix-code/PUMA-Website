<?php

namespace App\Models;

use App\Models\Members;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Cabinets extends Model
{
    /** @use HasFactory<\Database\Factories\CabinetsFactory> */
    use HasFactory;
    protected $fillable = ['name', 'term_start', 'term_end', 'status', 'description'];

    public function members() {
        return $this->hasMany(Members::class);
    }
}
