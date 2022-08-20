<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'wordpress' );

/** Database password */
define( 'DB_PASSWORD', 'updatepass' );

/** Database hostname */
define( 'DB_HOST', 'localhost' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'Og<&.%sx]t_&i/TRrB#PI} tDyZf82%[Ii@3fA9{i`0$FHw,~hxl;?-f3Z#<9BF?' );
define( 'SECURE_AUTH_KEY',  'W7?Z`JhA%V{J4xXp*XNFoj}MJ$+J%AjA|EO$`|j(pAKFvy[wF%X2a&dH<;KIn)Mo' );
define( 'LOGGED_IN_KEY',    '>Q:=#77S;UFMPlRLux#Kk_EMrv S!c66ArbQD:.yzwM+!p@aBUYo S5r1@P])A ^' );
define( 'NONCE_KEY',        ',0:g[j)k>5{c=DTHg7c9+Yb@l1+92/HUc2ZOJ+KK=X],;)W2hx7#Uq1s4<Z9.Md}' );
define( 'AUTH_SALT',        '@(QB4+E-]`%`{TAQnZz2Q}0f/cY-E1(_zX*fr@E<kg.]}H7!}bO=QAi<44#?[]Gg' );
define( 'SECURE_AUTH_SALT', 'Kv^dLf:)JNjkKR%-WnWzgB9ha^/:%CQdW4k{ts!XNts91vN7V*C@(vI7.{O|ka `' );
define( 'LOGGED_IN_SALT',   '-A(a)s(~J!^HF2:o+v=$oe1Y6XCU#AZ&l4ojmb8>q8q4kY~CRMMT.kFT4{HUu6L$' );
define( 'NONCE_SALT',       '0,Ldv+Gig+%k&18fY@wJ^ Un<Oy97`hf,vK8p<[1_C{Og!{oI$q;$I`VB|mQ^QMa' );

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
