(*
 * filename   : quote.ml
 * created at : 2012-10-24 08:49:05
 * author     : Jianing Yang <jianingy.yang AT gmail DOT com>
 *)

module Quote = struct

type tick = {time: float; opn: float; high: float; low: float; close: float; volume: float}
and trend = None | Trend of tick * trend
and chart = {symbol: string; period: int; trend: trend}

let read_from_csv fn ~timezone:tz =
  let trend_of_list = List.fold_left (fun acc x -> Trend(x, acc)) None in
  let trend_of_string s =
    let date_format = Str.global_replace (Str.regexp_string ".") "/" in
    let ts_of_date d t = Netdate.parse_epoch(date_format (d ^ " " ^ t ^ ":00")) -. (3600.0 *. tz) in
    let splitted = Str.split (Str.regexp_string ",") (String.trim s) in
    match splitted with
	d::t::opn::high::low::close::volume::_ -> {time = ts_of_date d t;
						   opn = float_of_string(opn);
						   high = float_of_string(high);
						   low = float_of_string(low);
						   close = float_of_string(close);
						   volume = float_of_string(volume)}
      | _ -> failwith "input file format error" in
  trend_of_list (List.map trend_of_string (Std.input_list (open_in fn)))

end ;;
