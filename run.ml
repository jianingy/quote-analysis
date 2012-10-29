(*
 * filename   : run.ml
 * created at : 2012-10-23 13:21:48
 * author     : Jianing Yang <jianingy.yang AT gmail DOT com>
 *)
#use "topfind" ;;
#require "extlib" ;;
#require "netstring" ;;
#require "str" ;;

#use "quote.ml" ;;

let t = Quote.read_from_csv ~timezone:1.0 "history/EURUSD60.csv"  in
t ;;
