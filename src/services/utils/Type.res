type url;
type searchParams;
@bs.new external createUrl: string => url = "URL";
@bs.get external searchParams: url => searchParams = "searchParams";
@bs.send external set_: (searchParams, string, string) => unit = "set";
@bs.get external href: url => string = "href";

@bs.module external uuidv4: unit => string = "uuid/v4";
@bs.val external localStorage: Dom.Storage2.t = "localStorage"
