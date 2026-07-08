-- Insert 100 Hotel Bookings

INSERT INTO hotel_bookings
(
    org_id,
    hotel_id,
    city,
    checkin_date,
    checkout_date,
    amount,
    status,
    created_at
)

SELECT

gen_random_uuid(),

'Hotel-' || ((g % 10)+1),

CASE

WHEN g % 5 = 0 THEN 'delhi'
WHEN g % 5 = 1 THEN 'mumbai'
WHEN g % 5 = 2 THEN 'hyderabad'
WHEN g % 5 = 3 THEN 'bangalore'
ELSE 'chennai'

END,

CURRENT_DATE + (g % 15),

CURRENT_DATE + (g % 15)+2,

(1000 + (random()*9000))::numeric(12,2),

CASE

WHEN g % 4 = 0 THEN 'CONFIRMED'
WHEN g % 4 = 1 THEN 'CANCELLED'
WHEN g % 4 = 2 THEN 'COMPLETED'
ELSE 'PENDING'

END,

NOW() - ((g % 30) * interval '1 day')

FROM generate_series(1,100) g;
