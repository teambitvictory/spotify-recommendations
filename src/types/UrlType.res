type url;
type searchParams;
@bs.new external createUrl: string => url = "URL";
@bs.get external searchParams: url => searchParams = "searchParams";
@bs.send external set_: (searchParams, string, string) => unit = "set";
@bs.get external href: url => string = "href";
