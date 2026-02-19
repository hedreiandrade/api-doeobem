<?php
/*
 * @author Hedrei Andrade <hedreiandrade@gmail.com>
 * @Version 1.0.0
 */
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Users extends Model
{
    use SoftDeletes;

    protected $table = 'users';
    protected $primaryKey = 'id';
    protected $fillable = [
        'name',
        'nickname',
        'phone1',
        'has_whatsapp',
        'phone2',
        'email',
        'password',
        'postal_code',
        'address',
        'number',
        'complement',
        'neighborhood',
        'city',
        'state',
        'country',
        'country_code',
        'state_code',
        'birth_date',
        'recovery_key',
        'first_access',
        'last_access',
        'access_count',
        'receive_newsletter',
        'active',
        'userscol',
        'photo',
        'cover_photo',
        'google_id',
        'auth_provider',
        'email_verified'
    ];
    protected $dates = [
        'created_at',
        'updated_at',
        'deleted_at'
    ];
}
