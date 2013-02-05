
/*!
 * druuid: Date-relative UUID generation.
 */

/**
 * Module dependencies.
 */

var bigint = require('bigint');

/**
 * Module exports.
 */

var druuid = module.exports = {};

/**
 * The offset from which druuid UUIDs are generated (in milliseconds).
 */

druuid.epoch = 0;

/**
 * Generates a time-sortable, 64-bit UUID.
 *
 * Examples:
 *
 *    druuid.gen()
 *    // => <BigInt 11142943683383068069>
 *
 * @param {Date} [date=new Date()] of UUID
 * @param {Number} [epoch=druuid.epoch] offset
 * @return {BigInt} UUID
 */

druuid.gen = function gen(date, epoch){
  if (!date) date = new Date();
  if (!epoch) epoch = druuid.epoch;
  var id = bigint(date - epoch).shiftLeft(63 - 40);
  return id.or(Math.round(Math.random() * 1e16) % Math.pow(2, 63 - 40));
};

/**
 * Determines when a given UUID was generated.
 *
 * Examples:
 *
 *     druuid.time(11142943683383068069);
 *     // => Sat Feb 04 2012 00:00:00 GMT-0800 (PST)
 *
 * @param {BigInt|Number|String} uuid
 * @param {Number} [epoch=druuid.epoch] offset
 * @return {Date} when UUID was generated
 */

druuid.time = function(uuid, epoch){
  if (!epoch) epoch = druuid.epoch;
  var ms = bigint(uuid).shiftRight(63 - 40).toNumber();
  return new Date(ms + epoch);
};
