import "@typespec/http";
import "@typespec/openapi3";

import "./models/common.tsp";
import "./models/owner.tsp";
import "./models/event-type.tsp";
import "./models/slot.tsp";
import "./models/booking.tsp";
import "./routes/public.tsp";
import "./routes/admin.tsp";

using Http;

/**
 * API сервиса бронирования времени (Calendly-подобный).
 *
 * Две роли без регистрации и авторизации:
 * - Владелец — единственный заранее заданный профиль; от его имени неявно
 *   работает админская часть (`/admin`).
 * - Гость — бронирует время без аккаунта и без входа (`/public`).
 */
@service(#{ title: "Calendar Booking API" })
@server("http://localhost:3000", "Локальный сервер для разработки")
namespace BookingApi;
