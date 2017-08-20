package main

import (
	"encoding/xml"
	"errors"
	"fmt"
	"io/ioutil"
	"net/http"
)

var FeedURL = "https://github.com/vim/vim/releases.atom"

type EntryLink struct {
	Href string `xml:"href,attr"`
}

type Entry struct {
	Link EntryLink `xml:"link"`
}

type Feed struct {
	Entries []Entry `xml:"entry"`
}

func main() {
	d, err := fetchXML(FeedURL)

	if err != nil {
		panic(err)
	}

	entries, err := parseXML(d)

	if err != nil {
		panic(err)
	}

	if len(entries) == 0 {
		panic(errors.New("No entry found in feed"))
	}

	fmt.Println(getVersionString(entries[0]))
}

func fetchXML(url string) ([]byte, error) {
	resp, err := http.Get(url)

	if err != nil {
		return nil, err
	}

	defer resp.Body.Close()
	return ioutil.ReadAll(resp.Body)
}

func parseXML(d []byte) ([]Entry, error) {
	feed := new(Feed)
	err := xml.Unmarshal(d, &feed)

	if err != nil {
		return nil, err
	}

	return feed.Entries, nil
}

func getVersionString(entry Entry) string {
	var ver string
	_, err := fmt.Sscanf(entry.Link.Href, "/vim/vim/releases/tag/v%s", &ver)

	if err != nil {
		panic(err)
	}

	return ver
}
